//
//  MineViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "MineViewController.h"
#import "FavoriteViewController.h"
#import "DownloadViewController.h"
#import "ContributeViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"
#import "UserInfoViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSMutableArray*data;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)UILabel*desLabel;
@property(nonatomic,strong)UIImageView*headIconView;
@end

@implementation MineViewController




-(NSMutableArray *)data{
    if (!_data) {
        NSArray*dataSource=@[
                             @[@{@"title":@"我的收藏",@"icon":@""},@{@"title":@"我的下载",@"icon":@""},@{@"title":@"我的投稿",@"icon":@""}],
                             @[@{@"title":@"关于我们",@"icon":@""},@{@"title":@"我的设置",@"icon":@""},@{@"title":@"推荐给好友",@"icon":@""}]];
        _data=[NSMutableArray arrayWithArray:dataSource];
    }
    return _data;
}

-(UIView *)headView{
    if (!_headView) {
        
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 210)];
        _headView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, kwidth, 190)];
        topView.backgroundColor=[UIColor whiteColor];
        [_headView addSubview:topView];
        
        
        UILabel*nickNameLabel=[UILabel labelWithFont:[UIFont systemFontOfSize:14] textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentCenter];
        nickNameLabel.frame=CGRectMake(5, 140, kwidth-10, 20);
        [topView addSubview:nickNameLabel];
        self.desLabel=nickNameLabel;
        
        UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake((kwidth-100)/2, 20, 100, 100)];
        icon.layer.cornerRadius=50;
        icon.userInteractionEnabled=YES;
        if (isLogin) {
            if ([[DataManager shareManager].userInfo.userHead isEqualToString:@"default"]) {
                //默认头像
                icon.image=[UIImageView getAppIcomImage];
            }else{
                //自定义
                NSString*iconStr=[DataManager shareManager].userInfo.userHead;
                icon.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",HomePath,iconStr]];
            }
            nickNameLabel.text=[DataManager shareManager].userInfo.userDes;
        }else{
            icon.image=[UIImageView getAppIcomImage];
            nickNameLabel.text=@"未登录";
        }
        
        icon.layer.masksToBounds=YES;
        [topView addSubview:icon];
        self.headIconView=icon;
        
        UIButton*coverBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.frame=CGRectMake(0, 0, kwidth, 190);
        coverBtn.backgroundColor=[UIColor clearColor];
        [coverBtn addTarget:self action:@selector(didClickOnUserInfo) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:coverBtn];
    
    }
    return _headView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!isLogin) {
        LoginViewController*login=[[LoginViewController alloc]init];
        NavgationBarController*nav=[[NavgationBarController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
            self.tabBarController.selectedIndex=0;
        }];
    }else{
        if ([[DataManager shareManager].userInfo.userHead isEqualToString:@"default"]) {
            //默认头像
            self.headIconView.image=[UIImageView getAppIcomImage];
        }else{
            //自定义
            NSString*iconStr=[DataManager shareManager].userInfo.userHead;
            self.headIconView.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",HomePath,iconStr]];
        }
        self.desLabel.text=[DataManager shareManager].userInfo.userDes;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text=self.data[indexPath.section][indexPath.row][@"title"];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.imageView.image=[[UIImage imageNamed:self.data[indexPath.section][indexPath.row][@"icon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.imageView.contentMode=UIViewContentModeScaleAspectFill;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?210:10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController*vc=nil;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:{
              //我的收藏
                vc=[[FavoriteViewController alloc]init];
            }
                break;
            case 1:{
                //我的下载
                vc=[[DownloadViewController alloc]init];
            }
                break;
            default:{
                //我的投稿
                vc=[[ContributeViewController alloc]init];
            }
                break;
        }
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:{
                //关于我们
                vc=[[AboutViewController alloc]init];
            }
                break;
                
            case 1:{
                //我的设置
                vc=[[SettingViewController alloc]init];
            }
                break;
                
            default:{
                //推荐好友
                NSLog(@"推荐好友");
            }
                break;
                
                
        }
    }
    if (vc!=nil) {
        vc.title=self.data[indexPath.section][indexPath.row][@"title"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return self.headView;
    }
    return nil;
}

-(void)didClickOnUserInfo{
    NSLog(@"点击个人信息");
    UserInfoViewController*user=[[UserInfoViewController alloc]init];
    user.title=@"个人信息";
    [self.navigationController pushViewController:user animated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
