//
//  LoginViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/12.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TopMargin;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.accountTextFiled resignFirstResponder];
    [self.pswTextFiled resignFirstResponder];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.image=[UIImageView blurryImage:[UIImage imageNamed:@"login_background"] withBlurLevel:0.7];
    self.iconView.image=[UIImageView getAppIcomImage];
    self.iconView.layer.borderWidth=2;
    self.iconView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.TopMargin.constant=kStatusBarHeight;
    
}

- (IBAction)GoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pswViewable:(UIButton *)sender {
        sender.selected=!sender.selected;
    self.pswTextFiled.secureTextEntry=!sender.selected;
}

- (IBAction)registerAndForget:(UIButton *)sender {
    NSLog(@"测试Tag===%ld",sender.tag);
    
    UIViewController*vc=nil;
    switch (sender.tag) {
        case 999:{
            //注册账号
            
            vc=[[RegisterViewController alloc]init];
        }
            break;
        default:{
            //忘记密码
            vc=[[ForgetViewController alloc]init];
            
        }
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)loginClick:(UIButton *)sender {
  
    NSLog(@"点击登录");
    
    [[NSUserDefaults standardUserDefaults]setObject:self.accountTextFiled.text forKey:@"userPhone"];
    
    if (self.accountTextFiled.text.length&&[NSString isValidateMobile:self.accountTextFiled.text]) {
        if (self.pswTextFiled.text.length) {
            if ([[DataManager shareManager]isExistWithPhone:self.accountTextFiled.text]) {
                if ([[[DataManager shareManager] userInfo].userPswd isEqualToString:self.pswTextFiled.text]) {
                    [MBProgressHUD showMessage:@""];
                    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(loginOk) userInfo:nil repeats:NO];
                }else{
                    [MBProgressHUD showError:@"账号或密码错误"];
                }
            }else{
                [MBProgressHUD showError:@"账号不存在"];
            }
        }else{
            [MBProgressHUD showError:@"请输入密码"];
        }
    }else{
        if (!self.accountTextFiled.text.length) {
            [MBProgressHUD showError:@"请输入手机号"];
        }else{
            [MBProgressHUD showError:@"请输入正确手机号"];
        }
    }
}

-(void)loginOk{
    [MBProgressHUD hideHUD];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextFiled resignFirstResponder];
    [self.pswTextFiled resignFirstResponder];
    [self.view endEditing:YES];
    
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
