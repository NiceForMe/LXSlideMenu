//
//  LXSlideMenu.h
//  LXSlideMenu
//
//  Created by XIAO on 2017/4/12.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LXSlideViewModel){
    LXSlideViewLeftModel,
    LXSlideViewRightModel,
};

@interface LXSlideMenu : UIView

/**
 model show menu from left or right
 */
@property (nonatomic,assign) LXSlideViewModel model;

/**
 init method

 @param model show menu from left or right
 @param superController the controller that display the menu
 @param slideMenu slidemenu (you need init it but don't set the frame)
 @param width the width for menu
 @param clickButton the button for the menu
 @return LXSlideMenu
 */
- (instancetype)initWithSlideViewModel:(LXSlideViewModel)model superController:(UIViewController *)superController slideMenu:(UIView *)slideMenu slideMenuWidth:(CGFloat)width clickButton:(UIButton *)clickButton;

@end
