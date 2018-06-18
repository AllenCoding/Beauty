//
//  BaseWebViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
#import <objc/message.h>

#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;

@interface BaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) UIProgressView *progressView;
@property(nonatomic,strong)UIView*bottomView;


@end

@implementation BaseWebViewController

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:CGRectMake(kwidth-70, kheight-120-kTabbarHeight, 50, 125)];
        _bottomView.backgroundColor=[UIColor clearColor];
    NSArray*images=@[@{@"normal":@"collect_normal",@"selected":@"collect_selected"},@{@"normal":@"icon_share",@"selected":@"icon_share"}];
        for (int i=0; i<images.count; i++) {
            CGRect frame=CGRectMake(5, i*55+15, 40, 40);
            UIButton*button=[UIButton buttonWithFrame:frame normalimageName:images[i][@"normal"] selectedImageName:images[i][@"selected"] target:self action:@selector(ClickOnButton:)];
            button.tag=i+999;
            [_bottomView addSubview:button];
            
        }
    }
    return _bottomView;
}

-(void)ClickOnButton:(UIButton*)button{
    NSLog(@"%ld",(long)button.tag);
    if (button.tag==999) {
        button.selected=!button.selected;
        if (button.selected) {
            NSLog(@"收藏成功");
        }else{
            NSLog(@"取消收藏成功");
        }
    }else{
        NSLog(@"我要分享");
    }
}


- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
    }
    return _wkConfig;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0 ,kwidth,kheight) configuration:self.wkConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.name;
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kwidth, 3)];
    self.progressView.backgroundColor = [UIColor blueColor];
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self startLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
    NSLog(@"返回来的参数--%@",self.html);
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.bottomView removeFromSuperview];
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            
            @weakify(self);
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weak_self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weak_self.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)startLoad {
    NSString *urlString = self.html;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 15.0f;
    [self.wkWebView loadRequest:request];
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];

}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
}
//移除监听
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
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
