//
//  TypeView.m
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "TypeView.h"

@interface TypeView ()

@end

@implementation TypeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (IBAction)selectTypeWithTag:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSArray*types=@[@"App",@"iOS",@"Android",@"前端",@"瞎推荐",@"拓展资源"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectType:)]) {
        [self.delegate didSelectType:types[sender.tag-990]];
    }
}

- (IBAction)emptyClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=990; i<996; i++) {
        UIButton*btn=(UIButton*)[self.view viewWithTag:i];
        btn.layer.shadowColor = [UIColor blackColor].CGColor;
        // 设置阴影的偏移量，默认是（0， -3）
        btn.layer.shadowOffset = CGSizeMake(8, 8);
        // 设置阴影不透明度，默认是0
        btn.layer.shadowOpacity = 0.9;
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
