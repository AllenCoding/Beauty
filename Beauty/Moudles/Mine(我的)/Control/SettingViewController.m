//
//  SettingViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray*data;
@end

@implementation SettingViewController

-(NSArray *)data{
    if (!_data) {
        _data=@[@"账号管理",@"清除缓存",@"退出登录"];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?2:1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=indexPath.section==0?self.data[indexPath.row]:self.data[indexPath.row+2];
    cell.textLabel.textColor=indexPath.section==0?[UIColor blackColor]:[UIColor redColor];
    cell.textLabel.textAlignment=indexPath.section==0?NSTextAlignmentLeft:NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:indexPath.section==0?16:18];
    cell.accessoryType=indexPath.section==0?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
             //修改密码
            };
                break;
                
            default:{
                //清除缓存
            }
                break;
        }
    }else{
        //注销登录
        //头像
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:nil message:@"是否确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*lib=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userPhone"];
            MainTabbar*tabbar=[[MainTabbar alloc]init];
            tabbar.selectedIndex=0;
            [[UIApplication sharedApplication].keyWindow setRootViewController:tabbar];
            
        }];
        UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alert addAction:lib];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
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
