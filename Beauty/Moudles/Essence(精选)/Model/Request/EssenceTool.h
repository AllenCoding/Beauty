//
//  EssenceTool.h
//  Beauty
//
//  Created by LiuYong on 2018/6/7.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

typedef void(^successBlock) (id list);
typedef void(^failureBlock) (NSError * error);

#import <Foundation/Foundation.h>

@interface EssenceTool : NSObject

@property(nonatomic,assign)int page;
@property(nonatomic,copy)NSString*type;

-(void)getEssenceDataSuccess:(successBlock)success AndFailure:(failureBlock)failure;

@end


@interface EssenceResult : NSObject
/*返回参数*/
@property(nonatomic,strong)NSMutableArray*results;
@property(nonatomic,assign)int count;

@end

