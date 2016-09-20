//
//  ZCControl.m
//  ZCNavigationControl
//
//  Created by zhangchao on 16/9/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCControl.h"
#import <objc/runtime.h>

#define NavigationBarBGColor [UIColor colorWithRed:32/255.0f green:177/255.0f blue:232/255.0f alpha:1]

@implementation UINavigationBar (ZC)
static char overlayerkey;

- (UIView *)overlayer
{
    return objc_getAssociatedObject(self, &overlayerkey);
}

- (void)setOverlayer:(UIView *)overlayer
{
    objc_setAssociatedObject(self, &overlayerkey, overlayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)zc_setBackgroundColor:(UIColor *)backgroundColor
{
    if(!self.overlayer) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlayer = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlayer.userInteractionEnabled = NO;
        self.overlayer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlayer atIndex:0];
    }
    self.overlayer.backgroundColor = backgroundColor;
}

- (void)zc_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")])    {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)zc_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)zc_setTransformidentity
{
    self.transform = CGAffineTransformIdentity;
}

- (void)zc_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlayer removeFromSuperview];
    self.overlayer = nil;
}
@end

@implementation UIView (ZC)
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect temp = self.frame;
    temp.origin.x = x;
    self.frame = temp;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect temp = self.frame;
    temp.origin.y = y;
    self.frame = temp;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect temp = self.frame;
    temp.size.width = width;
    self.frame = temp;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint temp = self.center;
    temp.x = centerX;
    self.center = temp;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint temp = self.center;
    temp.y = centerY;
    self.center = temp;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect temp = self.frame;
    temp.origin = origin;
    self.frame = temp;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect temp = self.frame;
    temp.size = size;
    self.frame = temp;
}

- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWithColor:(UIColor *)color Width:(CGFloat)width
{
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}
@end

@interface ZCControl ()
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,copy) NSString *title;
@end

@implementation ZCControl
const NSString * title;
static ZCControl *control = nil;
+ (ZCControl *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(control == nil)
        {
            control = [[ZCControl alloc] init];
        }
    });
    return control;
}

- (instancetype)init
{
    if(self = [super init]) {
        
    }
    return self;
}

- (void)setZCNavigationBarBackgroundColor:(UIColor *)backgroundColor TitleColor:(UIColor *)titleColor ItemColor:(UIColor *)itemColor
{
    _backgroundColor = backgroundColor;
    //设置导航
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               titleColor,NSForegroundColorAttributeName, nil];
    [[UINavigationBar  appearance] setBarTintColor:backgroundColor];
    [[UINavigationBar  appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar  appearance] setTintColor:itemColor];
}

- (void)setHeightOfGradient:(CGFloat)height AndScrollViewContentOffsetY:(CGFloat)contentOffsetY AndControl:(UIViewController *)control
{
    if(!_backgroundColor) {
        _backgroundColor = NavigationBarBGColor;
    }
    if(title.length <= 0) {
        if(control.title.length <= 0) {
            title = control.navigationController.title;
        } else {
            title = control.title;
        }
    }
    static CGFloat lastPosition;
    CGFloat INVALID_VIEW_HEIGHT = 64;
    if(contentOffsetY > height) {
        CGFloat alpha = MIN(1, 1 - ((height + INVALID_VIEW_HEIGHT - contentOffsetY) / INVALID_VIEW_HEIGHT));
        
        [control.navigationController.navigationBar zc_setBackgroundColor:[_backgroundColor colorWithAlphaComponent:alpha]];
        
        if(contentOffsetY - lastPosition > 5) {
            lastPosition = contentOffsetY;
        } else if(lastPosition - contentOffsetY > 5) {
            lastPosition = contentOffsetY;
        }
        control.title = alpha > 0.8 ? title : @"";
    } else {
        [control.navigationController.navigationBar zc_setBackgroundColor:[_backgroundColor colorWithAlphaComponent:0]];
    }
}
@end
