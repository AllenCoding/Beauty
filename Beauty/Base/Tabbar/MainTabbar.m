//
//  MainTabbar.m
//  CYW
//
//  Created by LiuYong on 2018/1/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainTabbar.h"
#import "CustomTabbar.h"
#import "NavgationBarController.h"

@interface MainTabbar ()<CustomTabBarDelegate,UITabBarDelegate>

@property (nonatomic, strong) UITabBarItem *lastItem;
@property(nonatomic,assign)NSInteger clickCount;

@end

@implementation MainTabbar

+ (void)initialize {
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(1, 1.5);
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtts[NSForegroundColorAttributeName] =mainColor;
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.lastItem=self.tabBar.selectedItem;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.clickCount=0;
    [self setUpTabbar];
    [self addChildViewControllerWithClassname:[HomeViewController description] imagename:@"home" title:@"干货"];
    [self addChildViewControllerWithClassname:[WelfareViewController description] imagename:@"welfare" title:@"福利"];
    [self addChildViewControllerWithClassname:[EssenceViewController description] imagename:@"essence" title:@"精选"];
    [self addChildViewControllerWithClassname:[MineViewController description] imagename:@"mine" title:@"我的"];
}


-(void)setUpTabbar{
    CustomTabbar*tab=[[CustomTabbar alloc]init];
    tab.tabBarDelegate=self;
    [self setValue:tab forKeyPath:@"tabBar"];
}

- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    NavgationBarController *nav = [[NavgationBarController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:imagename]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
}

-(void)tabBarDidClickPlusButton:(CustomTabbar *)tabBar{
    NSLog(@"点击我了");
//    UIViewController*releseVc=[[UIViewController alloc]init];
//    [self presentViewController:releseVc animated:YES completion:nil];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if (item == self.lastItem) { // 一样就发出通知
        self.clickCount++;
        if (self.clickCount==2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MainTabBarDidClickNotification" object:nil userInfo:nil];
            self.clickCount=0;
        }
    }
    // 将这次点击的UITabBarItem赋值给属性
    self.lastItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
