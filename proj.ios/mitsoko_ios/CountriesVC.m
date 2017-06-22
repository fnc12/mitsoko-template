//
//  CountriesVC.m
//  mitsoko_ios
//
//  Created by John Zakharov on 21.06.17.
//  Copyright © 2017 Mitsoko. All rights reserved.
//

#import "CountriesVC.h"

@interface CountriesVC ()

@end

@implementation CountriesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
