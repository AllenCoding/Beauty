//
//  DataManager.m
//  OFO
//
//  Created by ios on 2017/11/1.
//  Copyright © 2017年 OFO. All rights reserved.
//
//好看的皮囊千篇一律，有趣的灵魂万里挑一

#import "DataManager.h"
#import <FMDB.h>
static DataManager*_manager;

@interface DataManager(){
    FMDatabase*dataBase;
}

@end

@implementation DataManager

//只实例化一次
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((self == [super init])) {
            [self openData];
        }
    });
    return self;
}

+(instancetype)shareManager{
    
    return [[self alloc]init];
}

//只分配一次内存
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager==nil) {
            _manager=[super allocWithZone:zone];
        }
    });
    return _manager;
}

-(id)copyWithZone:(NSZone *)zone{
    return _manager;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return _manager;
}


-(void)openData{
    NSString*path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString*dbPath=[path stringByAppendingPathComponent:@"data.db"];
    dataBase=[FMDatabase databaseWithPath:dbPath];
    [dataBase open];
    [self createDatabase];
}

-(void)createDatabase{
    NSString*userSql=@"create table if not exists user(userId integer primary key autoincrement,userPhone text,userPswd,userNickname text,userHead text,userSex text,userDes text)";
    BOOL user=[dataBase executeUpdate:userSql];
    if (user) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
}

-(UserModel*)userInfo{
    NSString*selectSql=@"select *from user where userPhone=?";
    FMResultSet *set=[dataBase executeQuery:selectSql,userPhoneNumber];
    UserModel*user=[[UserModel alloc]init];
    while ([set next]) {
        user.userId=[set stringForColumn:@"userId"].integerValue;
        user.userPhone=[set stringForColumn:@"userPhone"];
        user.userPswd=[set stringForColumn:@"userPswd"];
        user.userNickname=[set stringForColumn:@"userNickname"];
        user.userSex=[set stringForColumn:@"userSex"];
        user.userHead=[set stringForColumn:@"userHead"];
        user.userDes=[set stringForColumn:@"userDes"];
    }
    return user;
}
-(void)userRegsiter:(UserModel*)user{
    NSString*user_sql=@"insert into user (userPhone,userPswd,userNickname,userSex,userHead,userDes) values(?,?,?,?,?,?)";
    BOOL isOk=[dataBase executeUpdate:user_sql,user.userPhone,user.userPswd,user.userNickname,user.userSex,user.userHead,user.userDes];
    if (isOk) {
        NSLog(@"用户注册成功");
    }else{
        NSLog(@"用户注册失败");
    }
}

//用户更新信息
-(void)updateUserInfoWithKey:(NSString*)key AndValue:(NSString*)value{
    NSString*psw_update=[NSString stringWithFormat:@"update user set %@= ?where userPhone=?",key];
    BOOL isSS = [dataBase executeUpdate:psw_update,value,userPhoneNumber];
    if (isSS) {
        [NSString stringWithFormat:@"用户%@更新成功",key];
        NSLog(@"%@",[NSString stringWithFormat:@"用户%@更新成功",key]);
    }else{
        NSLog(@"%@",[NSString stringWithFormat:@"用户%@更新失败",key]);
    }
}

-(BOOL)isExistWithPhone:(NSString *)phone{
    return [dataBase intForQuery:@"select count(*) from user where userPhone=?",phone];
}

@end


