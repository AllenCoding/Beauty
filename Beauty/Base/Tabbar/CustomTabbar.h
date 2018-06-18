//
//  CustomTabbar.h
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabbar;

@protocol CustomTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidClickPlusButton:(CustomTabbar *)tabBar;

@end


@interface CustomTabbar : UITabBar
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, weak) id <CustomTabBarDelegate> tabBarDelegate;
@end
