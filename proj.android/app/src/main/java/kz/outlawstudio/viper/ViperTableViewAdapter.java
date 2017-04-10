package kz.outlawstudio.viper;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListView;

import java.util.HashMap;
import java.util.Map;

public class ViperTableViewAdapter extends BaseAdapter {
    int adapterId;

    static int adId=1;      //  stars from 1 not 0 cause 0 is null in core

    final Map<String,View> cachedViews=new HashMap<>();
    final Map<Integer,View> cachedHeaders=new HashMap<>();
    ListView mListView;
    Context mContext;
    LayoutInflater mLayoutInflater;

    public ViperTableViewAdapter(ListView listView,Context context){
        adapterId=adId++;
        mListView=listView;
        mContext=context;
        mLayoutInflater=(LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        mListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                final IndexPath indexPath=getIndexPath(mListView,position);
                if(indexPath.getRow() >= 0){
                    didSelectRow(mListView,indexPath.getSection(),indexPath.getRow());
                }
            }
        });
    }

    @Override
    public boolean isEnabled(int position) {
        final IndexPath indexPath=getIndexPath(mListView,position);
        if(indexPath.getRow() >= 0){
            return true;
        }else{
            return false;       //  return false if row is actually header or footer..
        }
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
//        final ListView listView=(ListView)parent;
        final IndexPath indexPath=getIndexPath(mListView,position);
        switch(indexPath.getRow()){
            default:        //  if row not header/footer..

                //  get cell id from core..
                final String cellId=getRowId(mListView,indexPath.getSection(),indexPath.getRow());

                //  try to find cached view with this id..
                convertView=cachedViews.get(cellId);

                if(null==convertView){

                    //  get layout name from core..
                    final String layoutName=getRowLayoutName(mListView,indexPath.getSection(),indexPath.getRow());

                    //  obtain resource id of given layout..
                    int resID = mContext.getResources().getIdentifier(layoutName, "layout", mContext.getPackageName());

                    //  create view by res id..
                    convertView=mLayoutInflater.inflate(resID,parent,false);

                    //  add created to view to cache..
                    cachedViews.put(cellId,convertView);

                    //  fire core adapter's callback about cell created..
                    onRowCreated(mListView,convertView,indexPath.getSection(),indexPath.getRow());
                }

                //  fire core adapter's callback about cell displayed..
                onDisplayRow(mListView,convertView,indexPath.getSection(),indexPath.getRow());
                break;
            case -1: {
                final int section=indexPath.getSection();
                convertView = cachedHeaders.get(section);
                if (null == convertView) {

                    //  get layout name from core..
                    final String layoutName = getHeaderLayoutName(this.adapterId, section);

                    //  obtain resource id of given layout..
                    int resID = mContext.getResources().getIdentifier(layoutName, "layout", mContext.getPackageName());

                    //  create view by res id..
                    convertView = mLayoutInflater.inflate(resID, parent, false);

                    //  cached header view..
                    cachedHeaders.put(section,convertView);

                    //  fire core adapter's callback about header created..
                    onHeaderCreated(this.adapterId,convertView,section);
                }
            }break;
        }
        return convertView;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public Object getItem(int position) {
        return position;
    }

    @Override
    public int getCount() {
        int res=0;
        final int sectionsCount=getSectionsCount(this.adapterId);
        for(int i=0;i<sectionsCount;++i){
            int headersCount=getHeadersCount(i);
            res+=headersCount;
            int rowsCount=getRowsCount(mListView,i);
            res += rowsCount;
        }
        return res;
    }

    protected IndexPath getIndexPath(ListView listView, int position){
        final IndexPath res=new IndexPath(0,position);
        int headersCount=getHeadersCount(res.getSection());
        int rowsCount=getRowsCount(listView,res.getSection());
        while(res.getRow() >= rowsCount+headersCount){
            res.setSection(res.getSection()+1);
            res.setRow(res.getRow()-(headersCount+rowsCount));
            rowsCount=getRowsCount(listView,res.getSection());
            headersCount=getHeadersCount(res.getSection());
        }
        if(headersCount>0){
            if(res.getRow()<headersCount){
                res.setRow(-1);     //  -1 means section header..
            }else{
                res.setRow(res.getRow()-headersCount);
            }
        }
        return res;
    }

    protected int getHeadersCount(int section){
        double headerHeight=getHeaderHeight(this.adapterId,section);
        if(headerHeight>0){
            return 1;
        }else{
            return 0;
        }
    }

    protected native void didSelectRow(ListView listView,int section,int row);

    protected native void onDisplayRow(ListView listView,View rowView,int section,int row);

    protected native void onHeaderCreated(int adapterId,View headerView,int section);

    protected native void onRowCreated(ListView listView,View rowView,int section,int row);

    protected native String getHeaderLayoutName(int adapterId,int section);

    protected native String getRowLayoutName(ListView listView,int section,int row);

    protected native String getRowId(ListView listView,int section, int row);

    protected native int getSectionsCount(int adapterId);

    protected native int getRowsCount(ListView listView,int section);

    protected native double getHeaderHeight(int adapterId,int section);

    static class IndexPath{
        int mSection;
        int mRow;

        IndexPath(int section,int row){
            mSection=section;
            mRow=row;
        }

        public void setSection(int section){
            mSection=section;
        }

        public void setRow(int row){
            mRow=row;
        }

        public int getSection(){
            return mSection;
        }

        public int getRow(){
            return mRow;
        }
    }
}
