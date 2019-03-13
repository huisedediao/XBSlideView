//
//  SOSSlideView.m
//  XBSlideView
//
//  Created by xxb on 2019/3/13.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "SOSSlideView.h"

#define kColorGray [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]

@implementation SOSSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kColorGray;
        self.lb_right.backgroundColor = kColorGray;
        self.lb_right.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat selfHeight = rect.size.height;
    CGFloat btnWidth = selfHeight - self.spaceOfBtnAndBorder * 2 - self.spaceOfContentAndBorder * 2;
    self.spaceOfContentAndBorder = 5;
    self.layer.cornerRadius = selfHeight * 0.5;
    self.clipsToBounds = YES;
    self.spaceOfBtnAndBorder = 0;
    self.spaceOfBtnAndLabel = - btnWidth * 0.5;
    self.color_contentViewBackground = [UIColor redColor];
    [super drawRect:rect];
}

@end
