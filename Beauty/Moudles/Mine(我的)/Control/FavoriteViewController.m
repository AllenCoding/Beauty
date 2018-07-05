//
//  FavoriteViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView*sv;
@property(nonatomic,strong)UIButton*selectedBtn;
@end

@implementation FavoriteViewController

-(UIScrollView *)sv{
    if (!_sv) {
        _sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kTabbarHeight, kwidth, kheight-kNavgationBarHeight-kTabbarHeight)];
        _sv.delegate=self;
        _sv.contentSize=CGSizeMake(kwidth*3, kheight-kNavgationBarHeight-kTabbarHeight);
        _sv.pagingEnabled=YES;
        _sv.contentOffset=CGPointMake(0, 0);
        _sv.showsHorizontalScrollIndicator=NO;
    }
    return _sv;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.sv];
    
    WelfareViewController*v1=[[WelfareViewController alloc]init];
    EssenceViewController*v2=[[EssenceViewController alloc]init];
    HomeViewController*v3=[[HomeViewController alloc]init];
    NSArray*array=@[v1,v2,v3];
    for (int i=0; i<3; i++) {
        UIViewController*v=array[i];
        v.view.frame=CGRectMake(i*kwidth, 0, kwidth, kheight-kNavgationBarHeight-kTabbarHeight);
        [self addChildViewController:array[i]];
        [self.sv addSubview:v.view];
    }
    [self loadUI];
}

-(void)loadUI{
    
    NSArray*btns=@[@"妹子",@"精选",@"干货"];
    for (int i=0; i<[btns count]; i++) {
        UIButton*btn=[UIButton buttonWithTitle:btns[i] normalColor:[UIColor lightGrayColor] selectedColor:mainColor fontSize:15 target:self action:@selector(Click:)];
        btn.tag=i+100;
        btn.frame=CGRectMake(10*i+10+80*i, 10, 80, 30);
        [self.view addSubview:btn];
        if (i==0) {
            self.selectedBtn=btn;
            self.selectedBtn.selected=YES;
        }
    }
}

-(void)Click:(UIButton*)btn{
    btn.selected=!btn.selected;
    self.selectedBtn.selected=!self.selectedBtn.selected;
    self.selectedBtn=btn;
    [self.sv setContentOffset:CGPointMake((btn.tag-100)*kwidth, 0) animated:YES];
    btn.titleLabel.font=btn.selected?[UIFont boldSystemFontOfSize:16]:[UIFont systemFontOfSize:12];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UIButton*btn=[self.view viewWithTag:(scrollView.contentOffset.x/kwidth)+100];
    btn.selected=!btn.selected;
    self.selectedBtn.selected=!self.selectedBtn.selected;
    self.selectedBtn=btn;
    btn.titleLabel.font=btn.selected?[UIFont boldSystemFontOfSize:16]:[UIFont systemFontOfSize:12];
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
