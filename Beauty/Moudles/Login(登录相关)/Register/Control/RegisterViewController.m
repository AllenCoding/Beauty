//
//  LoginViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/12.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "RegisterViewController.h"
#import "ForgetViewController.h"



@interface RegisterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TopMargin;
@property (strong, nonatomic) IBOutlet UIButton *codeButton;
@property (strong, nonatomic) IBOutlet UITextField *pswTF;
@property(nonatomic,strong)UIImagePickerController*imagePicker;
@property(nonatomic,copy)NSString*headPicName;



@end

@implementation RegisterViewController

#pragma mark Lazy Load
-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.allowsEditing=YES;
        _imagePicker.delegate=self;
    }
    return _imagePicker;
}


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
    //头像
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction*lib=[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }];
    UIAlertAction*carmare=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert addAction:carmare];
    [alert addAction:lib];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


//获取验证码点击
- (IBAction)codeClick:(UIButton *)sender {
    
    if ([NSString isValidateMobile:self.accountTextFiled.text]) {
        
        if (![[DataManager shareManager]isExistWithPhone:self.accountTextFiled.text]) {
            //是合法手机号
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
                    });
                }
            });
            dispatch_resume(timer);
        }else{
            [MBProgressHUD showError:@"手机号已被注册"];
        }
    }else{
        //非法手机号
        [MBProgressHUD showError:@"手机格式有误"];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    self.iconView.image=image;
    self.headPicName=[NSString now];
    [self saveImage:image withName:self.headPicName];
    NSLog(@"选中那个图片的名字是---%@",self.headPicName);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//注册点击
- (IBAction)registerClick:(id)sender {
    
    if (self.accountTextFiled.text.length&&self.pswTextFiled.text.length) {
        if (self.pswTF.text.length>=6&&self.pswTF.text.length<=20) {
            //密码合法
            [SMSSDK commitVerificationCode:self.pswTextFiled.text phoneNumber:self.accountTextFiled.text zone:@"86" result:^(NSError *error) {
                if (!error) {
                    if ([[DataManager shareManager]isExistWithPhone:self.accountTextFiled.text]) {
                        [MBProgressHUD showError:@"该手机号已被注册"];
                    }else{
                        //注册成功
                        UserModel*model=[[UserModel alloc]init];
                        model.userId=[self.accountTextFiled.text integerValue];
                        model.userPswd=self.pswTF.text;
                        model.userPhone=self.accountTextFiled.text;
                        model.userSex=@"未设置";
                        model.userDes=@"这个家伙很懒，什么都没留下";
                        model.userNickname=@"未设置";
                        model.userHead=self.headPicName==nil?@"default":self.headPicName;
                        [[DataManager shareManager]userRegsiter:model];
                        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(registerOk) userInfo:nil repeats:NO];
                        [MBProgressHUD showMessage:@"正在提交"];
                    }
                }else{
                    [MBProgressHUD showError:@"验证码有误"];
                }
            }];
        }else{
            [MBProgressHUD showError:@"设置密码格式有误"];
        }
    }else{
        if (!self.accountTextFiled.text.length) {
            [MBProgressHUD showError:@"请填写手机号"];
        }else{
            [MBProgressHUD showError:@"请填写验证码"];
        }
    }
}
//登录成功跳转
-(void)registerOk{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"注册成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextFiled resignFirstResponder];
    [self.pswTextFiled resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    NSString *fullPath = [HomePath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
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
