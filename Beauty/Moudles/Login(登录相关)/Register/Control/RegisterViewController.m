//
//  LoginViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/12.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "RegisterViewController.h"
#import "ForgetViewController.h"

@interface RegisterViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TopMargin;
@property (strong, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)headViewClick:(id)sender {
    
    NSLog(@"点击头像了");
    
}


//获取验证码点击
- (IBAction)codeClick:(UIButton *)sender {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.accountTextFiled.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            [MBProgressHUD showSuccess:@"已发送"];
        }else{
            [MBProgressHUD showError:@"发送失败"];
        }
    }];
    
    __block int timeout = 60;
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    __weak typeof(self)weakSelf = self;
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        timeout --;
        if (timeout == 0) {
            //关闭定时器
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.codeButton.enabled=YES;
                [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [weakSelf.codeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.codeButton.enabled=NO;
                [weakSelf.codeButton setTitle:[NSString stringWithFormat:@"%ds后重试",timeout] forState:UIControlStateNormal];
                [weakSelf.codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

//注册点击
- (IBAction)registerClick:(id)sender {
    
    
    
    
    
    
    
    
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
