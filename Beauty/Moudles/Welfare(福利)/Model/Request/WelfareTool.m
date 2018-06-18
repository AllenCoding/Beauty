//
//  WelfareTool.m
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "WelfareTool.h"

@implementation WelfareTool

-(void)getWelfareDataSuccess:(successBlock)success AndFailure:(failureBlock)failure{
    NSString*urlString= [NSString stringWithFormat: @"data/福利/20/%d",self.page];
    [SNNetRequest getWithUrl:urlString andParameters:@{} andSuccess:^(id Json) {
        NSDictionary*dic=(NSDictionary*)Json;
        [WelfareResult mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"results":[WelfareModel class]};
        }];
        success([WelfareResult mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

@end

@implementation WelfareResult

@end
