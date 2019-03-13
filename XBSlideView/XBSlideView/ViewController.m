//
//  ViewController.m
//  XBSlideView
//
//  Created by xxb on 2019/3/12.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "ViewController.h"
#import "XBSlideView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    XBSlideView *view = [[XBSlideView alloc] initWithFrame:CGRectMake(10, 100, width, 55)];
    [self.view addSubview:view];
    view.bl_nodeIndexDidChanged = ^(NSInteger index) {
        NSLog(@"%ld",index);
    };
    view.lb_right.text = @"slide to send sos";
//    view.nodeCount = 5;
}


@end
