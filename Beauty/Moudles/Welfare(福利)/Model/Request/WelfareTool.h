//
//  WelfareTool.h
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WelfareModel.h"

typedef void(^successBlock) (id list);
typedef void(^failureBlock) (NSError * error);

@interface WelfareTool : NSObject

@property(nonatomic,assign)int page;

-(void)getWelfareDataSuccess:(successBlock)success AndFailure:(failureBlock)failure;

@end

@interface WelfareResult :NSObject
/*返回参数*/
@property(nonatomic,strong)NSMutableArray*results;

@end

