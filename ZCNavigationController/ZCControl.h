//
//  ZCControl.h
//  ZCNavigationControl
//
//  Created by zhangchao on 16/9/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ZCNavigationDelegate <NSObject>

@optional
/**
 设置导航栏的背景色，标题字体颜色，按钮字体颜色

 @param backgroundColor 背景色
 @param titleColor      标题字体颜色
 @param itemColor       按钮字体颜色
 */
- (void)setZCNavigationBarBackgroundColor:(UIColor *)backgroundColor TitleColor:(UIColor *)titleColor ItemColor:(UIColor *)itemColor;
/** 设置开始渐变的高度,传入scrollView的偏移时Y值 */
- (void)setHeightOfGradient:(CGFloat)height AndScrollViewContentOffsetY:(CGFloat)contentOffsetY AndControl:(UIViewController *)control;

@end

@interface UINavigationBar (ZC)
/** 设置背景色 */
- (void)zc_setBackgroundColor:(UIColor *)backgroundColor;
/** 设置alpha值 */
- (void)zc_setElementsAlpha:(CGFloat)alpha;
/** 设置偏移量 */
- (void)zc_setTranslationY:(CGFloat)translationY;
- (void)zc_setTransformidentity;
/** 置空 */
- (void)zc_reset;
@end

@interface UIView (ZC)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize size;

/** 设置圆径 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius;
/** 设置边框颜色，宽度 */
- (void)setBorderWithColor:(UIColor *)color Width:(CGFloat)width;
@end

@interface ZCControl : UIControl<ZCNavigationDelegate>
+ (ZCControl *)shared;
@end
