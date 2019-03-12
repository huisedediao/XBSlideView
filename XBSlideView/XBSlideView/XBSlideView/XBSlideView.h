//
//  XBSlideView.h
//  XBSlideView
//
//  Created by xxb on 2019/3/12.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBButton+CompatibleUIButton.h"


NS_ASSUME_NONNULL_BEGIN

@interface XBSlideView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIScrollView *sv_content;
@property (nonatomic,strong) UILabel *lb_left;
@property (nonatomic,strong) UILabel *lb_right;
@property (nonatomic,strong) XBButton *btn_sign;
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
