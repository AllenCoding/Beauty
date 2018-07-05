//
//  SetInfoViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/18.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "SetInfoViewController.h"

@interface SetInfoViewController ()
@property (strong, nonatomic) IBOutlet UITextField *inputTF;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation SetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTF.placeholder=self.type==1?@"请输入您的昵称":@"请输入您的个性签名";
    self.tipLabel.text=self.type==1?@"*昵称右4-10个英文字母、汉字或者符号组成":@"*个性签名不多于15个字";
    self.title=self.type==1?@"修改昵称":@"修改签名";
    self.inputTF.text=self.type==1?[DataManager shareManager].userInfo.userNickname:[DataManager shareManager].userInfo.userDes;
}

- (IBAction)updateInfo:(UIButton *)sender {
    if (self.type==1) {
        [[DataManager shareManager]updateUserInfoWithKey:@"userNickname" AndValue:self.inputTF.text];
    }else{
        [[DataManager shareManager]updateUserInfoWithKey:@"userDes" AndValue:self.inputTF.text];
    }
    self.callBlock(self.inputTF.text);
    [self.navigationController popViewControllerAnimated:YES];
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
