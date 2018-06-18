//
//  DataManager.h
//  Beauty
//
//  Created by LiuYong on 2018/6/15.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"



@interface DataManager : NSObject

/**
 初始化单例类
 */
+(instancetype)shareManager;

#pragma mark 用户信息管理

-(UserModel*)userInfo;

-(BOOL)isExistWithPhone:(NSString*)phone;

-(void)userRegsiter:(UserModel*)user;

-(void)updateUserInfoWithKey:(NSString*)key AndValue:(NSString*)value;

@end