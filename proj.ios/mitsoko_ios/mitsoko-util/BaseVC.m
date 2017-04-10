//
//  BaseVC.m
//  GoZebra
//
//  Created by John Zakharov on 08.02.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC () {
    BOOL _initializedInCore;
    NI *_ni;
}

@end

@implementation BaseVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
//        _ni = [NI shared];
        _viewId = -1;
        _initializedInCore = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!_initializedInCore){
        _initializedInCore = YES;
        _viewId = [self.ni viewCreated:self className:NSStringFromClass(self.class)];
//        NSLog(@"view id = %ld for %@", (long)_viewId, NSStringFromClass(self.class));
    }
    [self.ni viewWillAppearWithId:_viewId];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.ni viewDidAppearWithId:_viewId];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [_ni viewWillAppearWithId:_viewId];
    [self.ni viewWillDisappearWithId:_viewId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.ni viewDestroyed:_viewId];
}

- (NI *)ni {
    if(!_ni){
        _ni = [NI shared];
    }
    return _ni;
}

@end
