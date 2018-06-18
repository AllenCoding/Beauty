//
//  BaseWebViewController.h
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeData.h"
@interface BaseWebViewController : UIViewController
@property(nonatomic,strong)HomeData*data;
@property(nonatomic,copy)NSString*html;
@property(nonatomic,copy)NSString*name;
@end
