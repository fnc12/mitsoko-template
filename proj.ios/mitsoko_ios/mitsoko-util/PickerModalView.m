//
//  PickerModalView.m
//  MyFootball
//
//  Created by John Zakharov on 15.01.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import "PickerModalView.h"
//#import "UIView+FrameMagic.h"
//#import "CGExtra.h"

@interface PickerModalView () <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *_pickerView;
//    NSInteger _selectedEntityIndex;
}

@end

@implementation PickerModalView

- (instancetype)initWithFrame:(CGRect)frame entities:(NSArray*)entities {
    self = [super initWithFrame:frame];
    if(self){
        _entities = entities;
        _selectedEntityIndex = -1;
        
        CGSize s;
        CGPoint o;
        
        //=== _pickerView ===
        s = CGSizeMake(0, 0);
        o = CGPointMake(0, CGRectGetMaxY(self.toolbar.frame));
        _pickerView = [[UIPickerView alloc] initWithFrame:(CGRect){o, s}];
        CGRect f = _pickerView.frame;
        f.origin.x = (self.frame.size.width - _pickerView.frame.size.width) / 2;;
        _pickerView.frame = f;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }
    return self;
}

+ (PickerModalView*)showModalWithList:(NSArray*)entities {
    UIView *superview = [[UIApplication sharedApplication].delegate window];
    UIView *backgroundView = [[UIView alloc] initWithFrame:superview.bounds];
    backgroundView.alpha = 0;
    backgroundView.userInteractionEnabled = NO;
    backgroundView.backgroundColor = [UIColor blackColor];
    [superview addSubview:backgroundView];
    PickerModalView *res = [[PickerModalView alloc] initWithFrame:(CGRect){CGPointMake(0, superview.frame.size.height), superview.frame.size} entities:entities];
    res.backgroundView = backgroundView;
    [superview addSubview:res];
    [UIView animateWithDuration:0.25 animations:^{
        backgroundView.alpha = 0.5;
        backgroundView.userInteractionEnabled = YES;
        CGFloat dY = res.toolbar.frame.size.height + res.pickerView.frame.size.height;
        CGRect f = res.frame;
        f.origin.y -= dY;
        res.frame = f;
    } completion:^(BOOL finished) {
        //..
    }];
    return res;
}

- (UIView *)pickerView {
    return _pickerView;
}

- (void)backgroundView_Tap:(UIGestureRecognizer*)sender {
    [_delegate pickerModalViewCancelBtnTouched:self];
}

- (void)toolbar_DoneBtnTouched:(id)sender {
    [_delegate pickerModalViewDoneBtnTouched:self];
}

- (void)toolbar_CancelBtnTouched:(id)sender {
    [_delegate pickerModalViewCancelBtnTouched:self];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedEntityIndex = row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id res = _entities[row];
    if([res isKindOfClass:[NSString class]]){
        return res;
    }else{
        return [res description];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _entities.count;
}

@end
