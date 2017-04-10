//
//  DateModalView.h
//  MyFootball
//
//  Created by John Zakharov on 13.01.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import "ModalView.h"

@protocol DateModalViewDelegate;

@interface DateModalView : ModalView

@property (readonly) UIDatePicker *datePicker;
@property (weak) id<DateModalViewDelegate> delegate;

+ (DateModalView*)showModal;

- (instancetype)initWithFrame:(CGRect)frame;

//  override
- (void)toolbar_DoneBtnTouched:(id)sender;
- (void)toolbar_CancelBtnTouched:(id)sender;

@end

@protocol DateModalViewDelegate <NSObject>

@required

- (void)dateModalViewCancelBtnTouched:(DateModalView*)sender;
- (void)dateModalViewDoneBtnTouched:(DateModalView*)sender;

@end
