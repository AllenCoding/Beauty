//
//  EssenceTool.m
//  Beauty
//
//  Created by LiuYong on 2018/6/7.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "EssenceTool.h"
#import "WelfareModel.h"

@implementation EssenceTool
-(void)getEssenceDataSuccess:(successBlock)success AndFailure:(failureBlock)failure{
    NSString*urlString= [NSString stringWithFormat: @"search/query/listview/category/%@/count/20/page/%d",self.type,self.page];
    [SNNetRequest getWithUrl:urlString andParameters:@{} andSuccess:^(id Json) {
        NSDictionary*dic=(NSDictionary*)Json;
        [EssenceResult mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"results":[HomeData class]};
        }];
        success([EssenceResult mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

@end

@implementation EssenceResult

@end


