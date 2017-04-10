//
//  NI.h
//  Groozim
//
//  Created by John Zakharov on 19.05.16.
//  Copyright © 2016 Outlaw Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface NI : NSObject

+(NI*)shared;

//  storage..
//-(void)setDocumentsPath:(NSString*)documentsPath;

//  viper view..
//-(void)sendMessageToView:(NSInteger)viewId messageCode:(NSInteger)messageCode arguments:(NSDictionary<NSString*,NSString*> *)arguments;
-(void)sendMessageToView:(NSInteger)viewId messageCode:(NSInteger)messageCode arguments:(NSString*)arguments;
-(void)sendMessageToView:(NSInteger)viewId messageCode:(NSInteger)messageCode;
-(void)viewWillDisappearWithId:(NSInteger)viewId;
-(void)viewDidAppearWithId:(NSInteger)viewId;
-(void)viewWillAppearWithId:(NSInteger)viewId;
-(NSInteger)viewCreated:(id)view className:(NSString*)className;
-(void)viewDestroyed:(NSInteger)viewId;

@end

@interface UIControlTouchUpInsideEventHandler : NSObject

+(instancetype)shared;

@end

@interface UIControlValueChangedEventHandler : NSObject

+(instancetype)shared;

@end

@interface ViperTableViewAdapter : NSObject<UITableViewDataSource,UITableViewDelegate>

+(instancetype)shared;

@end

@interface UIAlertViewDelegateEventHandler : NSObject<UIAlertViewDelegate>

+(instancetype)shared;

@end

@interface UIActionSheetDelegateEventHandler : NSObject<UIActionSheetDelegate>

+(instancetype)shared;

@end

@interface UIImagePickerControllerDelegateEventHandler : NSObject<UIImagePickerControllerDelegate>

+(instancetype)shared;

@end

@interface UIBarButtonItemEventHandler : NSObject

+(instancetype)shared;

@end

@interface UITextViewDelegateEventHandler : NSObject<UITextViewDelegate>

+(instancetype)shared;

@end

@interface UIPickerViewDelegateEventHandler : NSObject

+(instancetype)shared;

- (id)showWithEntities:(NSArray<NSString*>*)entities
         selectedIndex:(NSInteger)selectedIndex;

@end

@interface MFMailComposeViewControllerDelegateEventHandler : NSObject<MFMailComposeViewControllerDelegate>

+ (instancetype)shared;

@end
