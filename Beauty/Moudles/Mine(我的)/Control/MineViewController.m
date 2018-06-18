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
#import "FootPrintViewController.h"
#import "NoteViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSMutableArray*data;
@property(nonatomic,strong)UIView*headView;
@end

@implementation MineViewController




-(NSMutableArray *)data{
    if (!_data) {
        NSArray*dataSource=@[
                             @[@{@"title":@"我的收藏",@"icon":@""},@{@"title":@"我的下载",@"icon":@""},@{@"title":@"我的投稿",@"icon":@""}],
                             @[@{@"title":@"我的足迹",@"icon":@""},@{@"title":@"我的笔记",@"icon":@""}],
                             @[@{@"title":@"关于我们",@"icon":@""},@{@"title":@"我的设置",@"icon":@""},@{@"title":@"推荐给好友",@"icon":@""}]];
        _data=[NSMutableArray arrayWithArray:dataSource];
    }
    return _data;
}

-(UIView *)headView{
    if (!_headView) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 180)];
        _headView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 170)];
        topView.backgroundColor=[UIColor whiteColor];
        [_headView addSubview:topView];
        
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
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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

//    if (indexPath.row==[self.data[indexPath.section] count]-1) {
//        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
//    }else{
//        self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
//    }
    
//    NSLog(@"返回来的行数:%d",[self.data[indexPath.section] count]);
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?180:10;
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
                //我的足迹
                vc=[[FootPrintViewController alloc]init];
            }
                break;
            default:{
                //我的笔记
                vc=[[NoteViewController alloc]init];
            }
                break;
        }
    }else{
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
 
 
 
 7.1  修改密码
 7.2 清除缓存
 7.3 退出登录
 8.

 
*/

@end
