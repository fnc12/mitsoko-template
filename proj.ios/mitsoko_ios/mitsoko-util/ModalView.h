//
//  ModalView.h
//  MyFootball
//
//  Created by John Zakharov on 15.01.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ModalViewDelegate;

@interface ModalView : UIView

@property (readonly) BOOL isDismissed;
@property (readonly) UIView *pickerView;
@property (readonly) UIToolbar *toolbar;
@property UIView *backgroundView;

- (instancetype)initWithFrame:(CGRect)frame;

//  protected:
- (void)toolbar_DoneBtnTouched:(id)sender;
- (void)toolbar_CancelBtnTouched:(id)sender;
- (void)backgroundView_Tap:(UIGestureRecognizer*)sender;

- (void)dismiss;

@end
