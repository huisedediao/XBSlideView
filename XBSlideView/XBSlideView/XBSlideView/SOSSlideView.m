//
//  SOSSlideView.m
//  XBSlideView
//
//  Created by xxb on 2019/3/13.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "SOSSlideView.h"

@interface SOSSlideView ()
@property (nonatomic,strong) UILabel *redView;
@end

@implementation SOSSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat selfHeight = rect.size.height;
    CGFloat btnWidth = selfHeight - self.spaceOfBtnAndBorder * 2 - self.spaceOfContentAndBorder * 2;
    
    self.redView = [UILabel new];
    [self.contentView addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spaceOfBtnAndBorder);
        make.height.mas_equalTo(btnWidth);
        make.right.equalTo(self.btn_sign);
        make.centerY.equalTo(self.contentView);
    }];
    self.redView.layer.cornerRadius = btnWidth * 0.5;
    self.redView.clipsToBounds = YES;
    self.redView.backgroundColor = [UIColor redColor];

    [self.contentView bringSubviewToFront:self.sv_content];

}



@end
