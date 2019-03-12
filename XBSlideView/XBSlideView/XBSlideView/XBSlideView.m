//
//  XBSlideView.m
//  XBSlideView
//
//  Created by xxb on 2019/3/12.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "XBSlideView.h"
#import "Masonry.h"


@interface XBSlideView ()
@property (nonatomic,assign) CGFloat maxOffsetOfX;
@end

@implementation XBSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
        self.isAdsorb = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIColor *btnTitleColor = [UIColor whiteColor];
    UIColor *labelColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    CGFloat spaceOfBtnAndBorder = 5;
    CGFloat spaceOfBtnAndLabel = 15;
    CGFloat selfWidth = rect.size.width;
    CGFloat selfHeight = rect.size.height;
    CGFloat btnWidth = selfHeight - spaceOfBtnAndBorder * 2;
    CGFloat labelWidth = selfWidth - spaceOfBtnAndBorder - spaceOfBtnAndLabel - btnWidth ;
    
    self.maxOffsetOfX = selfWidth - spaceOfBtnAndBorder * 2 - btnWidth;
    
    self.lb_left = ({
        UILabel *label = [UILabel new];
        [self.sv_content addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.sv_content);
            make.height.mas_equalTo(selfHeight);
            make.width.mas_equalTo(labelWidth);
        }];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"left";
        label.textColor = labelColor;
        label;
    });
    
    self.btn_sign = ({
        XBButton *btn = [XBButton new];
        [self.sv_content addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_left.mas_right).offset(spaceOfBtnAndLabel);
            make.centerY.equalTo(self.lb_left);
            make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
        }];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = btnWidth * 0.5;
        btn.str_titleNormal = @"SOS";
        btn.color_titleNormal = btnTitleColor;
        btn;
    });
    
    self.lb_right = ({
        UILabel *label = [UILabel new];
        [self.sv_content addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_sign.mas_right).offset(spaceOfBtnAndLabel);
            make.width.mas_equalTo(labelWidth);
            make.centerY.equalTo(self.lb_left);
            make.height.equalTo(self.lb_left);
            make.right.lessThanOrEqualTo(self.sv_content);
        }];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"right";
        label.textColor = labelColor;
        label;
    });
    
    self.contentView.layer.cornerRadius = selfHeight * 0.5;
    self.contentView.clipsToBounds = YES;
    
    [self setScrollViewOffsetForNode:self.selectedNodeIndex animated:NO];
}

- (void)setselectedNodeIndex:(NSInteger)selectedNodeIndex
{
    _selectedNodeIndex = selectedNodeIndex;
    
    [self setScrollViewOffsetForNode:selectedNodeIndex animated:YES];
}

- (void)setupSubviews
{
    self.contentView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        view;
    });
    
    self.sv_content = ({
        UIScrollView *view = [UIScrollView new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        view.delegate = self;
        view.bounces = NO;
        view.showsHorizontalScrollIndicator = NO;
        view;
    });
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self adsorb];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self adsorb];
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (CGFloat)partOffset
{
    return self.maxOffsetOfX / (self.nodeCount - 1);
}

- (void)adsorb
{
    if (self.isAdsorb == NO)
    {
        return;
    }
    CGFloat xOffset = self.sv_content.contentOffset.x;
    NSInteger nodeIndex = 0;
    for (NSInteger i = 1; i < self.nodeCount; i++)
    {
        CGFloat nextSegment = self.partOffset * i;
        if (xOffset < nextSegment)
        {
            if (xOffset + self.partOffset * 0.5 > nextSegment)
            {
                nodeIndex = self.nodeCount - i - 1;
            }
            else
            {
                nodeIndex = self.nodeCount - i;
            }
            break;
        }
    }
    [self setScrollViewOffsetForNode:nodeIndex animated:YES];
    if (self.selectedNodeIndex == nodeIndex)
    {
        return;
    }
    self.selectedNodeIndex = nodeIndex;
    if (self.bl_nodeIndexDidChanged)
    {
        self.bl_nodeIndexDidChanged(nodeIndex);
    }
}
- (void)setScrollViewOffsetForNode:(NSInteger)nodeIndex animated:(BOOL)animated
{
    CGFloat xOffset = self.maxOffsetOfX - self.partOffset * nodeIndex;
    [self.sv_content setContentOffset:CGPointMake(xOffset, 0) animated:animated];
}

- (NSInteger)nodeCount
{
    if (_nodeCount < 2)
    {
        return 2;
    }
    return _nodeCount;
}

@end
