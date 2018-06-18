//
//  ShareFit
//
//  Created by YNTS on 2017/9/28.
//  Copyright © 2017年 YNTS. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SNNetRequestManager : AFHTTPSessionManager
+ (SNNetRequestManager *)shareRequestManager;

@end
