//
//  XBSlideView.m
//  XBSlideView
//
//  Created by xxb on 2019/3/12.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "XBSlideView.h"

@interface XBSlideView ()
@property (nonatomic,assign) CGFloat maxOffsetOfX;
@end

@implementation XBSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.isAdsorb = YES;
        self.spaceOfBtnAndBorder = 5;
        self.spaceOfBtnAndLabel = 15;
        [self addObserver];
        
        [self setupSubviews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIColor *btnTitleColor = self.color_btnTitle;
    UIColor *labelColor = self.color_labelTitle;
    
    CGFloat selfWidth = rect.size.width;
    CGFloat selfHeight = rect.size.height;
    CGFloat contentViewWidth = selfWidth - self.spaceOfContentAndBorder * 2;
    CGFloat btnWidth = selfHeight - self.spaceOfBtnAndBorder * 2 - self.spaceOfContentAndBorder * 2;
    CGFloat labelWidth = contentViewWidth - self.spaceOfBtnAndLabel - btnWidth - self.spaceOfBtnAndBorder;
    
    self.maxOffsetOfX = contentViewWidth - 2 * self.spaceOfBtnAndBorder - btnWidth;
    
    [self.lb_left mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sv_content);
        make.top.equalTo(self.sv_content).offset(self.spaceOfBtnAndBorder);
        make.height.mas_equalTo(btnWidth);
        make.width.mas_equalTo(labelWidth);
    }];
    self.lb_left.textColor = labelColor;
    
    
    [self.btn_sign mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_left.mas_right).offset(self.spaceOfBtnAndLabel);
        make.centerY.equalTo(self.lb_left);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    self.btn_sign.backgroundColor = self.color_btnBackground;
    self.btn_sign.layer.cornerRadius = btnWidth * 0.5;
    self.btn_sign.color_titleNormal = btnTitleColor;
    
    
    [self.lb_right mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_sign.mas_right).offset(self.spaceOfBtnAndLabel);
        make.width.mas_equalTo(labelWidth);
        make.centerY.equalTo(self.lb_left);
        make.height.equalTo(self.lb_left);
        make.right.lessThanOrEqualTo(self.sv_content);
    }];
    self.lb_right.textColor = labelColor;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(self.spaceOfContentAndBorder);
        make.bottom.right.equalTo(self).offset(- self.spaceOfContentAndBorder);
    }];
    self.contentView.backgroundColor = self.color_contentViewBackground;
    self.contentView.layer.cornerRadius = (selfHeight - self.spaceOfContentAndBorder * 2) * 0.5;
    self.contentView.clipsToBounds = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setScrollViewOffsetForNode:self.selectedNodeIndex animated:NO];
    });
    
    [self.sv_content bringSubviewToFront:self.btn_sign];
}


#pragma mark - 观察者回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (_btn_sign == nil)
    {
        return;
    }
    if ([keyPath hasPrefix:@"color_"] ||
        [keyPath hasPrefix:@"spaceOf"])
    {
        [self setNeedsDisplay];
    }
}

- (void)addObserver
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *keyPath = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [self addObserver:self forKeyPath:[keyPath substringFromIndex:1] options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)dealloc
{
    NSLog(@"XBSlideView销毁");
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *keyPath = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [self removeObserver:self forKeyPath:[keyPath substringFromIndex:1]];
    }
}

- (void)setselectedNodeIndex:(NSInteger)selectedNodeIndex
{
    _selectedNodeIndex = selectedNodeIndex;
    
    [self setScrollViewOffsetForNode:selectedNodeIndex animated:YES];
}

- (void)setupSubviews
{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(self.spaceOfContentAndBorder);
        make.bottom.right.equalTo(self).offset(- self.spaceOfContentAndBorder);
    }];
    self.contentView.backgroundColor = self.color_contentViewBackground;
    
    [self.contentView addSubview:self.sv_content];
    [self.sv_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.sv_content.delegate = self;
    self.sv_content.bounces = NO;
    self.sv_content.showsHorizontalScrollIndicator = NO;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self adsorb];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self adsorb];
    NSLog(@"%f",self.maxOffsetOfX);
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
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
- (UIView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [UIView new];
    }
    return _contentView;
}
- (UIScrollView *)sv_content
{
    if (_sv_content == nil)
    {
        _sv_content = [UIScrollView new];
    }
    return _sv_content;
}
- (UILabel *)lb_left
{
    if (_lb_left == nil)
    {
        _lb_left = [UILabel new];
        [self.sv_content addSubview:_lb_left];
        _lb_left.textAlignment = NSTextAlignmentRight;
    }
    return _lb_left;
}
- (UILabel *)lb_right
{
    if (_lb_right == nil)
    {
        _lb_right = [UILabel new];
        [self.sv_content addSubview:_lb_right];
        _lb_right.textAlignment = NSTextAlignmentLeft;
    }
    return _lb_right;
}
- (XBButton *)btn_sign
{
    if (_btn_sign == nil)
    {
        _btn_sign = [XBButton new];
        [self.sv_content addSubview:_btn_sign];
    }
    return _btn_sign;
}
- (UIColor *)color_contentViewBackground
{
    if (_color_contentViewBackground == nil)
    {
        _color_contentViewBackground = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    }
    return _color_contentViewBackground;
}
- (UIColor *)color_btnBackground
{
    if (_color_btnBackground == nil)
    {
        _color_btnBackground = [UIColor redColor];
    }
    return _color_btnBackground;
}
- (UIColor *)color_btnTitle
{
    if (_color_btnTitle == nil)
    {
        _color_btnTitle = [UIColor whiteColor];
    }
    return _color_btnTitle;
}
- (UIColor *)color_labelTitle
{
    if (_color_labelTitle == nil)
    {
        _color_labelTitle = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    return _color_labelTitle;
}
@end

