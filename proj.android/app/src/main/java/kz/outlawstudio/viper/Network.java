package kz.outlawstudio.viper;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.SystemClock;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class Network{

    public static class ResponseTuple{

        static class Error{
            int mCode;
            String mText;

            public Error(int code, String text){
                mCode = code;
                mText = text;
            }

            public int getCode(){
                return mCode;
            }

            public String getText(){
                return mText;
            }
        }

        static class Response{
            int mStatusCode;
            String mStatusDescription;

            public Response(int statusCode, String statusDescription){
                mStatusCode = statusCode;
                mStatusDescription = statusDescription;
            }

            public int getStatusCode(){
                return mStatusCode;
            }

            public String getStatusDescription(){
                return mStatusDescription;
            }
        }

        Response mResponse = null;
        InputStream mDataStream = null;
        Error mError = null;

        public ResponseTuple(){
            //..
        }

        public void setResponse(Response response){
            mResponse = response;
        }

        public Response getResponse(){
            return mResponse;
        }

        public void setDataStream(InputStream dataStream){
            mDataStream = dataStream;
        }

        public InputStream getDataStream(){
            return mDataStream;
        }

        public void setError(Error error){
            mError = error;
        }

        public Error getError(){
            return mError;
        }
    }

    public static class UrlRequest extends AsyncTask<String, Void, ResponseTuple> {

        static class Header{
            String mKey;
            String mValue;

            public Header(String key, String value){
                mKey = key;
                mValue = value;
            }

            public String getKey(){
                return mKey;
            }

            public String getValue() {
                return mValue;
            }
        }

        String mHttpMethod = "GET";
        String mUrl = null;
        String mBodyString = null;

        byte[] mResponseData = null;
        Bitmap mBitmap = null;

        int mReturnType = 1;     //  enum like value. 1 means std::vector<char> will be returned. 2 -> Viper::Image

        Bitmap bitmap = null;

        int mId;

        static int nextId = 0;

        List<Header> mHeaders = new ArrayList<>();

        public UrlRequest(){
            mId = nextId++;
        }

        public int getId(){
            return mId;
        }

        public void perform(){
            this.execute();
        }

        public void setBodyString(String bodyString){
            mBodyString = bodyString;
        }

        public String getBodyString(){
            return mBodyString;
        }

        public void setValueForHTTPHeaderField(String value, String field) {
            mHeaders.add(new Header(field, value));
        }

        public void setReturnType(int returnType) {
            mReturnType = returnType;
        }

        public int getReturnType(){
            return mReturnType;
        }

        public void setHttpMethod(String httpMethod){
            mHttpMethod = httpMethod;
        }

        public String getHttpMethod(){
            return  mHttpMethod;
        }

        public void setUrl(String url){
            mUrl = url;
        }

        public String getUrl(){
            return mUrl;
        }

        @Override
        protected ResponseTuple doInBackground(String... strings) {
//            System.out.println("doInBackground url = "+mUrl);

            ResponseTuple responseTuple = new ResponseTuple();
//            ResponseTuple.Response response = null;
//            ResponseTuple.Error error = null;
//            InputStream dataStream = null;
            boolean isGet = mHttpMethod.equals("GET");

            try{
                URL url = new URL(mUrl);
                HttpURLConnection httpConnection = (HttpURLConnection)url.openConnection();
                httpConnection.setRequestMethod(mHttpMethod);
//            httpConnection.setRequestProperty("Content-length", "0");
                httpConnection.setUseCaches(false);
                httpConnection.setAllowUserInteraction(false);
                httpConnection.setConnectTimeout(100000);
                httpConnection.setDoInput(true);
                if(!isGet){
                    httpConnection.setDoOutput(true);
                }
                httpConnection.setReadTimeout(100000);
//                httpConnection.setRequestProperty("Content-Type","application/json");
                for(Header header : mHeaders){
                    httpConnection.setRequestProperty(header.getKey(), header.getValue());
                }

                //  write body if it exists..
                if(!isGet && null != mBodyString){
                    DataOutputStream wr = new DataOutputStream(httpConnection.getOutputStream());
                    System.out.println("mBodyString = " + mBodyString);
//                    wr.writeBytes(mBodyString);
                    byte[] buf = mBodyString.getBytes("UTF-8");
                    wr.write(buf, 0, buf.length);
                    wr.flush();
                    wr.close();
                }

                httpConnection.connect();

                int responseCode = httpConnection.getResponseCode();
                String responseMessage = httpConnection.getResponseMessage();
                responseTuple.setResponse(new ResponseTuple.Response(responseCode, responseMessage));

                System.out.println("responseMessage = "+responseMessage);
                if(responseCode / 100 == 2) {
                    responseTuple.setDataStream(httpConnection.getInputStream());
//                    bitmap = BitmapFactory.decodeStream(httpConnection.getInputStream());
//                if (responseCode == HttpURLConnection.HTTP_OK) {
                    /*if(!isGet){
                        BufferedReader br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
                        StringBuilder sb = new StringBuilder();
                        String line;
                        while ((line = br.readLine()) != null) {
                            sb.append(line + "\n");
                        }
                        br.close();
                        String result = sb.toString();
                        System.out.println("result = "+result);
                    }*/
//                    return result;
                }else{
                    responseTuple.setDataStream(httpConnection.getErrorStream());
                    responseTuple.setError(new ResponseTuple.Error(responseCode, responseMessage));
//                    System.out.println("status code = "+responseCode);
                    /*BufferedReader br = new BufferedReader(new InputStreamReader(httpConnection.getErrorStream()));
                    StringBuffer sb = new StringBuffer();
                    String line;
                    while ((line = br.readLine()) != null) {
                        sb.append(line + "\n");
                    }
                    br.close();
                    String result = sb.toString();
                    return result;*/
                }
            }catch (IOException e){
                e.printStackTrace();
                responseTuple.setError(new ResponseTuple.Error(-1, e.getLocalizedMessage()));
            }catch (Exception e){
                e.printStackTrace();
                responseTuple.setError(new ResponseTuple.Error(-1, e.getLocalizedMessage()));
            }

            switch(mReturnType){
                case 1:     //  std::vector<char>>..
                    try{
                        mResponseData = inputStreamToByte(responseTuple.getDataStream());
//                        System.out.println("mResponseData = " + new String(mResponseData));
                        System.out.println("first ten bytes:");
                        for(int i=0; i<10; ++i) {
                            System.out.print(mResponseData[i]);
                            System.out.println();
                        }
                    }catch (IOException e){
                        e.printStackTrace();
                    }
                    break;
                case 2:     //  Viper::Image
                    mBitmap = BitmapFactory.decodeStream(responseTuple.getDataStream());
                    break;
            }
            return responseTuple;
        }

        @Override
        protected void onPostExecute(ResponseTuple responseTuple) {
            super.onPostExecute(responseTuple);

//            System.out.println("responseTuple = " + responseTuple + ", id = " + mId);
            System.out.println("onPostExecute url = "+mUrl);

            //  post response tuple [response, data, error] into c++
//            InputStream is;

            switch(mReturnType){
                case 1:
                    NI.shared().urlResponseReceived(mId,
                            responseTuple.getResponse(),
                            mResponseData,
                            responseTuple.getError());
                    break;
                case 2:
                    NI.shared().urlResponseImageReceived(mId,
                            responseTuple.getResponse(),
                            mBitmap,
                            responseTuple.getError());
                    break;
            }

            /*byte[] bytes = s.getBytes();
            Bitmap bm = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);

            imageView.setImageBitmap(bm);*/
        }

        @SuppressWarnings("empty-statement")
        public static byte[] inputStreamToByte(InputStream is) throws IOException {
            if (is == null) {
                return null;
            }
            // Define a size if you have an idea of it.
            ByteArrayOutputStream r = new ByteArrayOutputStream(2048);
            byte[] read = new byte[512]; // Your buffer size.
            for (int i; -1 != (i = is.read(read)); r.write(read, 0, i));
            is.close();
            return r.toByteArray();
        }
    }
}