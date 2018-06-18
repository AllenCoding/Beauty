//
//  UserModel.h
//  Beauty
//
//  Created by LiuYong on 2018/6/15.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,assign)NSInteger userId;//人员编号
@property(nonatomic,copy)NSString*userPhone;//手机
@property(nonatomic,copy)NSString*userNickname;//昵称
@property(nonatomic,copy)NSString*userHead;//头像
@property(nonatomic,copy)NSString*userSex;//性别
@property(nonatomic,copy)NSString*userDes;//微信

@end
