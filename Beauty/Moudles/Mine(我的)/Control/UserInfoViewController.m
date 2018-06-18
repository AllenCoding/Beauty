//
//  UserInfoViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/18.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollviewHeight;
@property (strong, nonatomic) IBOutlet UIImageView *profileView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *desLabel;
@property(nonatomic,strong)UIImagePickerController*imagePicker;

@end

@implementation UserInfoViewController

-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.allowsEditing=YES;
        _imagePicker.delegate=self;
    }
    return _imagePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];

}

-(void)loadUI{
    self.scrollviewHeight.constant=kheight-kNavgationBarHeight+1;
    if ([[DataManager shareManager].userInfo.userHead isEqualToString:@"default"]) {
        //默认头像
        self.profileView.image=[UIImageView getAppIcomImage];
    }else{
        //自定义
        NSString*iconStr=[DataManager shareManager].userInfo.userHead;
        self.profileView.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",HomePath,iconStr]];
    }
    self.desLabel.text=[DataManager shareManager].userInfo.userDes;
    self.nickNameLabel.text=[DataManager shareManager].userInfo.userNickname;
    self.phoneLabel.text=[DataManager shareManager].userInfo.userPhone;
    self.sexLabel.text=[DataManager shareManager].userInfo.userSex;
}



- (IBAction)didSelectAtIndexWithTag:(UIButton *)sender {
    switch (sender.tag) {
        case 995:{
            //换头像
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
            break;
        case 996:{
            
            //换昵称
        }
            break;
        case 997:{
            //换性别
        }
            break;
        case 998:{
            //换手机号

        }
            break;
        default:{
            //换签名
            
        }
            break;
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    self.profileView.image=image;
    NSString*imageName=[NSString now];
    [self saveImage:image withName:imageName];
    [[DataManager shareManager]updateUserInfoWithKey:@"userHead" AndValue:imageName];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
