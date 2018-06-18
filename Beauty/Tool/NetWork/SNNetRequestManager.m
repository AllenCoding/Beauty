//
//  ShareFit
//
//  Created by YNTS on 2017/9/28.
//  Copyright © 2017年 YNTS. All rights reserved.
//

#import "SNNetRequestManager.h"

static SNNetRequestManager * _manager;

@implementation SNNetRequestManager
+ (SNNetRequestManager *)shareRequestManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[SNNetRequestManager alloc] initWithBaseURL:[NSURL URLWithString:mainUrl]];
        _manager.requestSerializer.timeoutInterval=10;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    });
    return _manager;
}
@end
