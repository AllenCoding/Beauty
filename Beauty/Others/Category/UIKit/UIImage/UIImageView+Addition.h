//
//  UIImageView+Addition.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 获取应用Icon图片
 @return 图片对象
 */
+(UIImage*)getAppIcomImage;

/**
 获取启动页图片
 @return 图片对象
 */
+(UIImage*)getLanuchImage;


@end
