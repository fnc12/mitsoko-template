//
//  DateModalView.m
//  MyFootball
//
//  Created by John Zakharov on 13.01.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import "DateModalView.h"
//#import "UIView+FrameMagic.h"
//#import "CGExtra.h"

@interface DateModalView () {
//    UIToolbar *_toolbar;
}

@end

@implementation DateModalView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        
        CGSize s;
        CGPoint o;
        
        //=== _datePicker ===
        s = CGSizeMake(0, 0);
        o = CGPointMake(0, CGRectGetMaxY(self.toolbar.frame));
        _datePicker = [[UIDatePicker alloc] initWithFrame:(CGRect){o, s}];
        CGRect f = _datePicker.frame;
        f.origin.x = (self.frame.size.width - _datePicker.frame.size.width) / 2;
        _datePicker.frame = f;
        [self addSubview:_datePicker];
    }
    return self;
}

#pragma mark - Public

+ (DateModalView*)showModal {
    UIView *superview = [[UIApplication sharedApplication].delegate window];
    UIView *backgroundView = [[UIView alloc] initWithFrame:superview.bounds];
    backgroundView.alpha = 0;
    backgroundView.userInteractionEnabled = NO;
    backgroundView.backgroundColor = [UIColor blackColor];
    [superview addSubview:backgroundView];
    DateModalView *res = [[DateModalView alloc] initWithFrame:(CGRect){CGPointMake(0, superview.frame.size.height), superview.frame.size}];
    res.backgroundView = backgroundView;
    [superview addSubview:res];
    [UIView animateWithDuration:0.25 animations:^{
        backgroundView.alpha = 0.5;
        backgroundView.userInteractionEnabled = YES;
        CGFloat dY = res.toolbar.frame.size.height + res.datePicker.frame.size.height;
        CGRect f = res.frame;
        f.origin.y -= dY;
        res.frame = f;
    } completion:^(BOOL finished) {
        //..
    }];
    return res;
}

#pragma mark - Properties

- (UIView *)pickerView {
    return _datePicker;
}

#pragma mark - Events

- (void)backgroundView_Tap:(UIGestureRecognizer*)sender {
    [_delegate dateModalViewCancelBtnTouched:self];
}

- (void)toolbar_DoneBtnTouched:(id)sender {
    [_delegate dateModalViewDoneBtnTouched:self];
}

- (void)toolbar_CancelBtnTouched:(id)sender {
    [_delegate dateModalViewCancelBtnTouched:self];
}

@end
