//
//  HomeTool.m
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "HomeTool.h"

@implementation HomeTool

-(void)getHomeDataSuccess:(successBlock)success AndFailure:(failureBlock)failure{
    NSString*urlString= [NSString stringWithFormat: @"data/%@/20/%d",self.type,self.page];
    [SNNetRequest getWithUrl:urlString andParameters:@{} andSuccess:^(id Json) {
        NSDictionary*dic=(NSDictionary*)Json;
        [HomeDataResult mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"results":[HomeData class]};
        }];
        success([HomeDataResult mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}


@end


@implementation HomeDataResult


@end


