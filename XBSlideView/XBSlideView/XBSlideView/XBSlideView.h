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
@property (nonatomic,assign) NSInteger i_selectedNodeIndex;
@property (nonatomic,copy) void (^bl_nodeIndexDidChanged)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
