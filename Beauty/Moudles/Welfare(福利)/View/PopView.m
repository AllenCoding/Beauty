//
//  PopView.m
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "PopView.h"



@interface PopView ()

@property (strong, nonatomic) IBOutlet UIButton *collectBtn;
@property (strong, nonatomic) IBOutlet UIButton *downloadBtn;

@property (strong, nonatomic) IBOutlet UIImageView *profileView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploaderLabel;


@end

@implementation PopView
- (IBAction)blankClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    self.downloadBtn.selected=[[DataManager shareManager]isDownLoaded:self.welfare._id];
    self.downloadBtn.enabled=![[DataManager shareManager]isDownLoaded:self.welfare._id];
    if (!self.downloadBtn.enabled) {
        [self.downloadBtn setImage:[UIImage imageNamed:@"download_selected"] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
         self.bgView.transform = CGAffineTransformIdentity;
        [self.view addSubview:self.bgView];
    } completion:^(BOOL finished) {
        
    }];
    
    [self.profileView sd_setImageWithURL:[NSURL URLWithString:self.welfare.url] placeholderImage:[UIImage imageNamed:@"placeholder_image"]];
    self.uploaderLabel.text=self.welfare.who;
    
    if ([self.welfare.createdAt containsString:@"T"]) {
      NSString*time=  [self.welfare.createdAt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        if ([time containsString:@"Z"]) {
            NSString*subTime=[time stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
            self.timeLabel.text=subTime;
        }else{
            self.timeLabel.text=time;
        }
    }else{
        self.timeLabel.text=self.welfare.createdAt;
    }
}

- (IBAction)PopViewClickAction:(UIButton *)sender {
    if (!isLogin) {
        [MBProgressHUD showError:@"您还没登录哦！"];
        LoginViewController*loginVc=[[LoginViewController alloc]init];
        [self presentViewController:loginVc animated:YES completion:nil];
    }else{
        if (sender.tag==999) {
            //下载
            [MBProgressHUD showMessage:@""];

            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.welfare.url]];
            UIImage*  img = [UIImage imageWithData:data];
            // 保存图片到相册中
            UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
            sender.selected=YES;
            
//            NSLog(@"沙盒路径是------%@",NSHomeDirectory());
//            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.welfare.url] options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//                NSLog(@"下载进度是：%.3f",(float)receivedSize/(float)expectedSize);
//            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//
//            }];
            
        }else{
            //收藏
            sender.selected=!sender.selected;
            
            
            
        }
    }
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    [MBProgressHUD hideHUD];
    if (error != NULL){
        // Show error message…
        NSLog(@"下载失败");
    }else{
    
        // Show message image successfully saved
        NSLog(@"下载成功");
        self.downloadBtn.selected=YES;
        
        HomeData*data=[[HomeData alloc]init];
        data._id=self.welfare._id;
        data.publishedAt=self.welfare.createdAt;
        data.url=self.welfare.url;
        data.who=self.welfare.who;
        [[DataManager shareManager]downloadByDataModel:data];
        
        
        NSLog(@"下载的图片的id是：%@",data._id);
        [MBProgressHUD showSuccess:@"下载成功"];
        [self dismissViewControllerAnimated:NO completion:nil];
        
//        5b33ccf2421aa95570db5478
//        5b33ccf2421aa95570db5478
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
