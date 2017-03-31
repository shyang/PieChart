//
//  ViewController.m
//  PieChart
//
//  Created by shaohua on 30/03/2017.
//  Copyright © 2017 syang. All rights reserved.
//

#import "ViewController.h"
#import "TTPieView.h"

@interface ViewController ()

@property (nonatomic) TTPieView *pieView;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [_pieView removeFromSuperview];
    _pieView = [[TTPieView alloc] initWithFrame:self.view.bounds];
    _pieView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _pieView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pieView];
    [_pieView setObject:@[@100, @200, @300]];
}

@end
