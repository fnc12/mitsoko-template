//
//  BaseVC.h
//  GoZebra
//
//  Created by John Zakharov on 08.02.17.
//  Copyright © 2017 Outlaw Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NI.h"

@interface BaseVC : UIViewController

@property (readonly) NI *ni;
@property (readonly) NSInteger viewId;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void)viewDidLoad;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)dealloc;

@end
