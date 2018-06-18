//
//  UIViewController+Addition.m
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

+ (void)load {
    //我们只有在开发的时候才需要查看哪个viewController将出现
    //所以在release模式下就没必要进行方法的交换
#ifdef DEBUG
    //原本的viewWillAppear方法
    Method viewWillAppear = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    //需要替换成 能够输出日志的viewWillAppear
    Method logViewWillAppear = class_getInstanceMethod([self class], @selector(logViewWillAppear:));
    //两方法进行交换
    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
#endif
}

- (void)logViewWillAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"\n\n***********%@ will appear ***********\n\n",className);
    [self logViewWillAppear:animated];
    
}



- (BOOL)isCurrentAndVisibleViewController {
    return self.isViewLoaded && self.view.window;
}

- (void)pushToNextViewController:(UIViewController *)nextVC {
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}






@end
