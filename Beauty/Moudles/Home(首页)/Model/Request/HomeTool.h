//
//  HomeTool.h
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeData.h"

typedef void(^successBlock) (id list);
typedef void(^failureBlock) (NSError * error);

@interface HomeTool : NSObject

@property(nonatomic,assign)int page;
@property(nonatomic,copy)NSString*type;

-(void)getHomeDataSuccess:(successBlock)success AndFailure:(failureBlock)failure;


@end


@interface HomeDataResult :NSObject
/*返回参数*/
@property(nonatomic,strong)NSMutableArray*results;

@end



