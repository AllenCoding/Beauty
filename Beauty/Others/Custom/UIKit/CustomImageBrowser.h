//
//  CustomImageBrowser.h
//  Beauty
//
//  Created by LiuYong on 2018/6/29.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlock)(void);

@class CustomImageBrowser;

@interface CustomImageBrowser : UIViewController

@property(nonatomic,copy)DeleteBlock block;

-(instancetype)initWithimages:(NSArray *)images andSelectedImageIndex:(int)selectedIndex;

@end
