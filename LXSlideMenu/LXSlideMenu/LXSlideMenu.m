//
//  LXSlideMenu.m
//  LXSlideMenu
//
//  Created by XIAO on 2017/4/12.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import "LXSlideMenu.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LXSlideMenu ()
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIView *slideMenu;
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic,strong) UIPanGestureRecognizer *slideMenupanGesture;
@property (nonatomic,assign) CGFloat menuWidth;
@property (nonatomic,assign) CGFloat menuHeight;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,strong) UIButton *clickButton;
@property (nonatomic,assign) BOOL isShowMenu;
@property (nonatomic,strong) UIViewController *controller;
@end

@implementation LXSlideMenu
- (instancetype)initWithSlideViewModel:(LXSlideViewModel)model superController:(UIViewController *)superController slideMenu:(UIView *)slideMenu slideMenuWidth:(CGFloat)width clickButton:(UIButton *)clickButton
{
    if (self = [super init]) {
        UIView *superView = superController.view;
        self.centerX = superView.center.x;
        self.centerY = superView.center.y;
        self.isShowMenu = NO;
        self.model = model;
        self.containerView = superView;
        self.slideMenu = slideMenu;
        self.menuWidth = width;
        self.menuHeight = superView.frame.size.height;
        CGFloat menuY;
        if (superController.navigationController) {
            menuY = superController.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        }else{
            menuY = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        if (self.model == LXSlideViewLeftModel) {
            self.frame = CGRectMake(-width, menuY, width,self.menuHeight);
        }else{
            self.frame = CGRectMake(superView.frame.size.width, menuY, width, self.menuHeight);
        }
        slideMenu.frame = self.bounds;
        [self addSubview:slideMenu];
        [self.containerView addGestureRecognizer:self.panGesture];
        [clickButton addTarget:self action:@selector(showSlideMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma panGesture
- (UIPanGestureRecognizer *)panGesture
{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    }
    return _panGesture;
}
#pragma handlePan
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation = [pan translationInView:pan.view];
    CGFloat x = pan.view.center.x + translation.x;
    if (self.model == LXSlideViewLeftModel) {
        if (x >= self.menuWidth + self.centerX) {
            x = self.menuWidth + self.centerX;
        }
        if (x <= self.centerX) {
            x = self.centerX;
        }
        if (pan.state == UIGestureRecognizerStateChanged) {
            self.containerView.center = CGPointMake(x, self.centerY);
        }
        if (pan.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.2 animations:^{
                if (x > self.centerX + self.menuWidth / 2) {
                    self.containerView.center = CGPointMake(self.centerX + self.menuWidth, self.centerY);
                    self.isShowMenu = YES;
                }else{
                    self.containerView.center = CGPointMake(self.centerX, self.centerY);
                    self.isShowMenu = NO;
                }
            }];
        }
    }else{
        if (x <= - (self.menuWidth + self.centerX - ScreenWidth)) {
            x = - (self.menuWidth + self.centerX - ScreenWidth);
        }
        if (x >= self.centerX) {
            x = self.centerX;
        }
        if (pan.state == UIGestureRecognizerStateChanged) {
            self.containerView.center = CGPointMake(x, self.centerY);
        }
        if (pan.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.2 animations:^{
                if (x < self.centerX - self.menuWidth / 2) {
                    self.containerView.center = CGPointMake(self.centerX - self.menuWidth, self.centerY);
                    self.isShowMenu = YES;
                }else{
                    self.containerView.center = CGPointMake(self.centerX, self.centerY);
                    self.isShowMenu = NO;
                }
            }];
        }
    }
    [pan setTranslation:CGPointMake(0, 0) inView:pan.view];
}
#pragma showSlideMenu
- (void)showSlideMenu
{
    if (self.model == LXSlideViewLeftModel) {
        [UIView animateWithDuration:0.2 animations:^{
            if (self.isShowMenu == NO) {
                self.containerView.center = CGPointMake(self.centerX + self.menuWidth, self.centerY);
                self.isShowMenu = YES;
            }else{
                self.containerView.center = CGPointMake(self.centerX, self.centerY);
                self.isShowMenu = NO;
            }
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            if (self.isShowMenu == NO) {
                self.containerView.center = CGPointMake(self.centerX - self.menuWidth, self.centerY);
                self.isShowMenu = YES;
            }else{
                self.containerView.center = CGPointMake(self.centerX, self.centerY);
                self.isShowMenu = NO;
            }
        }];
    }
}
@end
