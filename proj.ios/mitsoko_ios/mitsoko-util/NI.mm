//
//  NI.m
//  Groozim
//
//  Created by John Zakharov on 19.05.16.
//  Copyright © 2016 Outlaw Studio. All rights reserved.
//

#import "NI.h"
#import "PickerModalView.h"

#include "Mitsoko/ViperGod.hpp"
#include "Mitsoko/TableListAdapter.hpp"
#include "Mitsoko/iOSutil/UI/PickerView.hpp"
#include "Mitsoko/iOSutil/MF/MailCompose/ViewController.hpp"

static const char* cStringFromClientString(NSString*);
static NSString* clientStringFromStdString(const std::string&);

@implementation NI

+(NI *)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res = [self new];
    });
//    [NSMutableURLRequest new].timeoutInterval
    return res;
}

#pragma mark - Mitsoko view

-(void)sendMessageToView:(NSInteger)viewId
             messageCode:(NSInteger)messageCode
               arguments:(NSString*)arguments
{
    Mitsoko::God::shared.sendMessageToView(viewId, int(messageCode), arguments.UTF8String);
}

-(void)sendMessageToView:(NSInteger)viewId messageCode:(NSInteger)messageCode{
    Mitsoko::God::shared.sendMessageToView(viewId, int(messageCode));
}

-(void)viewWillDisappearWithId:(NSInteger)viewId{
    Mitsoko::God::shared.viewWillDisappear(viewId);
}

-(void)viewDidAppearWithId:(NSInteger)viewId{
    Mitsoko::God::shared.viewDidAppear(viewId);
}

-(void)viewWillAppearWithId:(NSInteger)viewId{
    Mitsoko::God::shared.viewWillAppear(viewId);
}

-(NSInteger)viewCreated:(id)view className:(NSString*)className{
    auto v = CFBridgingRetain(view);
    auto res = Mitsoko::God::shared.createView(cStringFromClientString(className), (const void*)v);
    CFRelease(v);
    return res;
}

-(void)viewDestroyed:(NSInteger)viewId;{
    Mitsoko::God::shared.destroyView(viewId);
}

@end

static const char* cStringFromClientString(NSString *s){
    return s.UTF8String;
}

static NSString* clientStringFromStdString(const std::string &s){
    return [NSString stringWithCString:s.c_str() encoding:NSUTF8StringEncoding];
}

@implementation ViperTableViewAdapter

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    auto tableOrListView = CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    return Mitsoko::TableListAdapter::sectionsCount(tableOrListView);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    auto tableOrListView = CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    return Mitsoko::TableListAdapter::rowsCount(tableOrListView, int(section));
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    auto tableOrListView=CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    int row=int(indexPath.row);
    int section=int(indexPath.section);
    NSString *cellId=clientStringFromStdString(Mitsoko::TableListAdapter::rowId(tableOrListView, section, row));
    UITableViewCell *res=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(nil==res){
        NSString *cellClassName=clientStringFromStdString(Mitsoko::TableListAdapter::cellClassName(tableOrListView, section, row));
        Class cellClass=NSClassFromString(cellClassName);
        UITableViewCellStyle cellStyle=(UITableViewCellStyle)Mitsoko::TableListAdapter::cellStyle(tableOrListView,
                                                                                                  section,
                                                                                                  row);
        res=[[cellClass alloc]initWithStyle:cellStyle reuseIdentifier:cellId];
        auto cell=CFBridgingRetain(res);
        CFRelease(cell);
        Mitsoko::TableListAdapter::cellCreated(tableOrListView, cell, section, row);
    }
    return res;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    auto tableOrListView = CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    return Mitsoko::TableListAdapter::headerHeight(tableOrListView, int(section));
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    auto tableOrListView=CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    NSString *viewClassName=clientStringFromStdString(Mitsoko::TableListAdapter::headerViewClassName(tableOrListView,
                                                                                                   int(section)));
    if(viewClassName.length){
        if(Class cls=NSClassFromString(viewClassName)){
            id res=[[cls alloc]init];
            auto headerView=CFBridgingRetain(res);
            CFRelease(headerView);
            Mitsoko::TableListAdapter::headerCreated(tableOrListView, headerView, int(section));
            return res;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    auto tableOrListView=CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    int row=int(indexPath.row);
    int section=int(indexPath.section);
    return Mitsoko::TableListAdapter::rowHeight(tableOrListView, section, row);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    auto tableOrListView=CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    int row=int(indexPath.row);
    int section=int(indexPath.section);
    Mitsoko::TableListAdapter::didSelectRow(tableOrListView, section, row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    auto tableOrListView=CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    int row=int(indexPath.row);
    int section=int(indexPath.section);
    auto c=CFBridgingRetain(cell);
    CFRelease(c);
    Mitsoko::TableListAdapter::willDisplayCell(tableOrListView, c, section, row);
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    auto tableOrListView=CFBridgingRetain(tableView);
    CFRelease(tableOrListView);
    int row=int(indexPath.row);
    int section=int(indexPath.section);
    auto c=CFBridgingRetain(cell);
    CFRelease(c);
    Mitsoko::TableListAdapter::didEndDisplayingCell(tableOrListView, c, section, row);
}

@end

@implementation UIAlertViewDelegateEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
//    [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
    return res;
}

-(void)alertViewCancel:(UIAlertView *)alertView{
//    NSLog(@"alertViewCancel");
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    auto aw=CFBridgingRetain(alertView);
    CFRelease(aw);
    UI::AlertView::DelegateEventHandler::alertViewWillDismissWithButtonIndex(aw, int(buttonIndex));
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    auto aw=CFBridgingRetain(alertView);
    CFRelease(aw);
//    Viper::alertViewClickedButtonAtIndex(aw, int(buttonIndex));
    UI::AlertView::DelegateEventHandler::alertViewClickedButtonAtIndex(aw, int(buttonIndex));
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    auto aw=CFBridgingRetain(alertView);
    CFRelease(aw);
    UI::AlertView::DelegateEventHandler::alertViewDidDismissWithButtonIndex(aw, int(buttonIndex));
}

@end

@implementation UIActionSheetDelegateEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet{
    //..
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    auto as=CFBridgingRetain(actionSheet);
    CFRelease(as);
    UI::ActionSheet::DelegateEventHandler::actionSheetClickedButtonAtIndex(as, int(buttonIndex));
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    auto as=CFBridgingRetain(actionSheet);
    CFRelease(as);
    UI::ActionSheet::DelegateEventHandler::actionSheetDidDismissWithButtonIndex(as, int(buttonIndex));
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    auto as=CFBridgingRetain(actionSheet);
    CFRelease(as);
    UI::ActionSheet::DelegateEventHandler::actionSheetWillDismissWithButtonIndex(as, int(buttonIndex));
}

@end

@implementation UIImagePickerControllerDelegateEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    auto p=CFBridgingRetain(picker);
    CFRelease(p);
    UI::ImagePickerController::DelegateEventHandler::imagePickerControllerDidCancel(p);
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    auto p=CFBridgingRetain(picker);
    CFRelease(p);
    auto i=CFBridgingRetain(info);
    CFRelease(i);
    UI::ImagePickerController::DelegateEventHandler::imagePickerControllerDidFinishPickingMediaWithInfo(p, i);
}

@end

@implementation UIControlValueChangedEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

-(void)actionDidHappen:(id)sender{
    auto s=CFBridgingRetain(sender);
    CFRelease(s);
    UI::Control::EventHandler<UI::Control::Events::ValueChanged>::actionDidHappen(s);
}

@end

@implementation UIControlTouchUpInsideEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

-(void)actionDidHappen:(id)sender{
    auto s=CFBridgingRetain(sender);
    CFRelease(s);
    UI::Control::EventHandler<UI::Control::Events::TouchUpInside>::actionDidHappen(s);
}

@end

@implementation UIBarButtonItemEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
//    [[UIButton new] setTag:0];
    return res;
}

-(void)barButtonItemTouched:(id)sender{
    auto handle=CFBridgingRetain(sender);
    CFRelease(handle);
    UI::BarButtonItem::touched(handle);
}

@end

@implementation UITextViewDelegateEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    return UI::TextView::DelegateEventHandler::textViewShouldBeginEditing(sender);
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    return UI::TextView::DelegateEventHandler::textViewShouldEndEditing(sender);
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    UI::TextView::DelegateEventHandler::textViewDidBeginEditing(sender);
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    UI::TextView::DelegateEventHandler::textViewDidEndEditing(sender);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    auto t=CFBridgingRetain(text);
    CFRelease(t);
    return UI::TextView::DelegateEventHandler::textViewShouldChangeTextInRange(sender, range, t);
}

- (void)textViewDidChange:(UITextView *)textView{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    UI::TextView::DelegateEventHandler::textViewDidChange(sender);
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    UI::TextView::DelegateEventHandler::textViewDidChangeSelection(sender);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
//    [NSURL new].absoluteString
//    [NSHTTPURLResponse localizedStringForStatusCode:404];
//    [UIImage new]
    
    auto sender=CFBridgingRetain(textView);
    CFRelease(sender);
    auto url=CFBridgingRetain(URL);
    CFRelease(url);
    return UI::TextView::DelegateEventHandler::textViewShouldInteractWithURL(sender, url, characterRange);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    auto sender = CFBridgingRetain(textView);
    CFRelease(sender);
    auto ta = CFBridgingRetain(textAttachment);
    CFRelease(ta);
    return UI::TextView::DelegateEventHandler::textViewShouldInteractWithTextAttachment(sender, ta, characterRange);
}

@end

@interface UIPickerViewDelegateEventHandler () <PickerModalViewDelegate>

@end

@implementation UIPickerViewDelegateEventHandler

+(instancetype)shared{
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

- (id)showWithEntities:(NSArray<NSString*>*)entities selectedIndex:(NSInteger)selectedIndex {
    auto pickerModalView = [PickerModalView showModalWithList:entities];
    pickerModalView.delegate = self;
    [((UIPickerView*)pickerModalView.pickerView) selectRow:selectedIndex
                                               inComponent:0
                                                  animated:NO];
    return pickerModalView;
}

#pragma mark - PickerModalViewDelegate

- (void)pickerModalViewCancelBtnTouched:(PickerModalView*)sender {
    auto s = CFBridgingRetain(sender);
    CFRelease(s);
    auto it = UI::PickerView::cancelCallbacks.find(s);
    if(it != UI::PickerView::cancelCallbacks.end()) {
        auto cb = it->second;
        if(cb){
            cb(int(sender.selectedEntityIndex));
        }
        UI::PickerView::cancelCallbacks.erase(it);
    }
    [sender dismiss];
}

- (void)pickerModalViewDoneBtnTouched:(PickerModalView*)sender {
//    auto index = sender.selectedEntityIndex;
    auto s = CFBridgingRetain(sender);
    CFRelease(s);
    auto it = UI::PickerView::doneCallbacks.find(s);
    if(it != UI::PickerView::doneCallbacks.end()) {
        auto cb = it->second;
        if(cb){
            cb(int(sender.selectedEntityIndex));
        }
        UI::PickerView::doneCallbacks.erase(it);
    }
    [sender dismiss];
}

@end

@implementation MFMailComposeViewControllerDelegateEventHandler

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static id res;
    dispatch_once(&onceToken, ^{
        res=[self new];
    });
    return res;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    auto c = CFBridgingRetain(controller);
    CFRelease(c);
    MF::MailCompose::ViewController::didFinishWithResult((__bridge const void *)controller, MF::MailCompose::Result(result));
}

@end
