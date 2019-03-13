//
//  XBSlideView.h
//  XBSlideView
//
//  Created by xxb on 2019/3/12.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBButton+CompatibleUIButton.h"
#import "Masonry.h"
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBSlideView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIScrollView *sv_content;
@property (nonatomic,strong) UILabel *lb_left;
@property (nonatomic,strong) UILabel *lb_right;
@property (nonatomic,strong) XBButton *btn_sign;
/** contentView的背景颜色，默认灰色0.5透明 */
@property (nonatomic,strong) UIColor *color_contentViewBackground;
/** btn_sign的背景颜色，默认红色 */
@property (nonatomic,strong) UIColor *color_btnBackground;
/** btn_sign的文字颜色，默认白色 */
@property (nonatomic,strong) UIColor *color_btnTitle;
/** lb_left\lb_right的文字颜色，默认白色0.7透明 */
@property (nonatomic,strong) UIColor *color_labelTitle;
/** contentView到自身边缘的距离，默认0 */
@property (nonatomic,assign) CGFloat spaceOfContentAndBorder;
/** button到contentView边缘的距离，默认5 */
@property (nonatomic,assign) CGFloat spaceOfBtnAndBorder;
/** button和文字的距离,默认15 */
@property (nonatomic,assign) CGFloat spaceOfBtnAndLabel;
/** 节点数量 */
@property (nonatomic,assign) NSInteger nodeCount;
/** 是否自动吸附最近的节点，默认yes */
@property (nonatomic,assign) BOOL isAdsorb;
/** 选中的节点 */
@property (nonatomic,assign) NSInteger selectedNodeIndex;
/** 节点变化的回调 */
@property (nonatomic,copy) void (^bl_nodeIndexDidChanged)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
