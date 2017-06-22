//
//  ViewController.m
//  mitsoko_ios
//
//  Created by John Zakharov on 09.04.17.
//  Copyright © 2017 Mitsoko. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize s;
    CGPoint o;
    CGSize b = self.view.bounds.size;
    
    /*_textField = [UITextField new];
    s = CGSizeMake(b.width / 2, 40);
    o = CGPointMake((b.width - s.width) / 2, 100);
    _textField.frame = (CGRect){o, s};
    _textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textField];*/
    
    _mainBtn = [UIButton new];
    s = CGSizeMake(b.width * 0.7, 40);
    o = CGPointMake((b.width - s.width) / 2, 100 + 30);
    _mainBtn.frame = (CGRect){o, s};
    [self.view addSubview:_mainBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
