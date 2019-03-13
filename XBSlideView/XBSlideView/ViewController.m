//
//  ViewController.m
//  XBSlideView
//
//  Created by xxb on 2019/3/12.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "ViewController.h"
#import "XBSlideView.h"
#import "SOSSlideView.h"

@interface ViewController ()
@property (nonatomic,strong) XBSlideView *slideView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createSlideView];
    [self createSlideView_2];
}

- (void)createSlideView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    XBSlideView *view = [[XBSlideView alloc] initWithFrame:CGRectMake(10, 100, width, 55)];
    [self.view addSubview:view];
    view.bl_nodeIndexDidChanged = ^(NSInteger index) {
        NSLog(@"%ld",index);
    };
    view.lb_right.text = @"slide to send sos";
    view.btn_sign.str_titleNormal = @"sos";
    view.color_contentViewBackground = [UIColor orangeColor];
    view.color_btnTitle = [UIColor purpleColor];
    view.color_labelTitle = [UIColor blackColor];
    view.color_btnBackground = [UIColor yellowColor];
    self.slideView = view;
}
- (void)createSlideView_2
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    SOSSlideView *view = [[SOSSlideView alloc] initWithFrame:CGRectMake(10, 300, width, 100)];
    [self.view addSubview:view];
    view.bl_nodeIndexDidChanged = ^(NSInteger index) {
        NSLog(@"%ld",index);
    };
    view.lb_right.text = @"slide to send sos";
    view.btn_sign.str_titleNormal = @"sos";
    self.slideView = view;
}

@end
