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
    if (sender.tag==999) {
        //下载
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.welfare.url]];
        UIImage*  img = [UIImage imageWithData:data];
        // 保存图片到相册中
        UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }else{
        //收藏
        sender.selected=!sender.selected;

    }
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    if (error != NULL){
        // Show error message…
        NSLog(@"下载失败");
    }else{
        // Show message image successfully saved
        NSLog(@"下载成功");
        self.downloadBtn.selected=YES;
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
