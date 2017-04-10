//
//  PickerModalView.h
//  MyFootball
//
//  Created by John Zakharov on 15.01.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import "ModalView.h"

@protocol PickerModalViewDelegate;

@interface PickerModalView : ModalView

@property (weak) id<PickerModalViewDelegate> delegate;
@property (readonly) NSInteger selectedEntityIndex;
@property (readonly) NSArray *entities;

- (instancetype)initWithFrame:(CGRect)frame entities:(NSArray*)entities;

+ (PickerModalView*)showModalWithList:(NSArray*)entities;

@end

@protocol PickerModalViewDelegate <NSObject>

@required

- (void)pickerModalViewCancelBtnTouched:(PickerModalView*)sender;
- (void)pickerModalViewDoneBtnTouched:(PickerModalView*)sender;

@end
