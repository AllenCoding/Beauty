//
//  UtilsHeader.h
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#ifndef UtilsHeader_h
#define UtilsHeader_h

#define kwidth  [UIScreen mainScreen].bounds.size.width
#define kheight  [UIScreen mainScreen].bounds.size.height
#define kTabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kNavgationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

#define DT_KEY_WINDOW [UIApplication sharedApplication].delegate.window
#define DT_TOP_SPACE IOS11_OR_LATER_SPACE(DT_KEY_WINDOW.safeAreaInsets.top)
#define DT_TOP_ACTIVE_SPACE IOS11_OR_LATER_SPACE(MAX(0, DT_KEY_WINDOW.safeAreaInsets.top-20))
#define DT_BOTTOM_SPACE IOS11_OR_LATER_SPACE(DT_KEY_WINDOW.safeAreaInsets.bottom)
#define kStatusBarHeight (kheight ==812? 44 : 20)



/*用户登录信息*/
#define isNetReachable [[NSUserDefaults standardUserDefaults]boolForKey:@"NetWorkReachable"]
#define isLogin [[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"]
#define userPhoneNumber  [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"]
#define isFirstInstall [[NSUserDefaults standardUserDefaults]boolForKey:@"isFirstInstall"]



#endif /* UtilsHeader_h */
