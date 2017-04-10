//
//  ModalView.m
//  MyFootball
//
//  Created by John Zakharov on 15.01.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import "ModalView.h"
//#import "UIView+FrameMagic.h"
//#import "CGExtra.h"
//#import "Localizator.h"

@interface ModalView () {
    UIView *_backgroundView;
}

@end

@implementation ModalView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        CGSize b = self.frame.size;
        CGSize s;
        CGPoint o;
        
        UIBarButtonItem*(^createFixedWidthBarButtonItem)() = ^{
            UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                     target:nil
                                                                     action:nil];
            res.width = 20;
            return res;
        };
        
        //=== _toolbar ===
        s = CGSizeMake(b.width, 44);
        o = CGPointMake(0, 0);
        _toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){o, s}];
        _toolbar.items = @[createFixedWidthBarButtonItem(),
                           [[UIBarButtonItem alloc] initWithTitle:@"Отмена"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(toolbar_CancelBtnTouched:)],
                           [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                         target:nil
                                                                         action:nil],
                           [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                            style:UIBarButtonItemStyleDone
                                                           target:self
                                                           action:@selector(toolbar_DoneBtnTouched:)],
                           createFixedWidthBarButtonItem(),];
        [self addSubview:_toolbar];
    }
    return self;
}

#pragma mark - Properties

- (UIView *)pickerView {
    return nil;
}

- (void)setBackgroundView:(UIView *)backgroundView {
    _backgroundView = backgroundView;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(backgroundView_Tap:)]];
}

- (UIView *)backgroundView {
    return _backgroundView;
}

#pragma mark - Public

- (void)dismiss {
    if(!_isDismissed){
        _isDismissed = YES;
        self.backgroundView.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.25
                         animations:^{
                             self.backgroundView.alpha = 0;
                             CGFloat dY = self.toolbar.frame.size.height + self.pickerView.frame.size.height;
                             CGRect f = self.frame;
                             f.origin.y += dY;
                             self.frame = f;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                             [self.backgroundView removeFromSuperview];
                         }];
    }else{
        NSLog(@"%@: already dismissed",self.class);
    }
}

#pragma mark - Events

- (void)backgroundView_Tap:(UIGestureRecognizer *)sender {
    //..
}

- (void)toolbar_DoneBtnTouched:(id)sender {
//    [_delegate dateModalViewDelegateDoneBtnTouched:self];
}

- (void)toolbar_CancelBtnTouched:(id)sender {
//    [_delegate dateModalViewDelegateCancelBtnTouched:self];
}

@end
