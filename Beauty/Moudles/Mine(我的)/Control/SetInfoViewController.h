//
//  SetInfoViewController.h
//  Beauty
//
//  Created by LiuYong on 2018/6/18.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetInfoViewController : UIViewController
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)void(^callBlock) (NSString*text);
@end
