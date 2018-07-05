//
//  CustomImageBrowser.m
//  Beauty
//
//  Created by LiuYong on 2018/6/29.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "CustomImageBrowser.h"
#import "WelfareModel.h"

@interface CustomImageBrowser ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray*images;
@property(nonatomic,assign)int selectedIndex;
@property(nonatomic,strong)UIScrollView*contentScrollView;
@end

@implementation CustomImageBrowser

-(instancetype)initWithimages:(NSArray *)images andSelectedImageIndex:(int)selectedIndex{
    if (self = [super init]) {
        self.images=images;
        self.selectedIndex=selectedIndex;
    }
    return self;
}

-(UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight-kNavgationBarHeight-80)];
        _contentScrollView.contentSize=CGSizeMake(kwidth*self.images.count, kheight-kNavgationBarHeight-80);
        _contentScrollView.pagingEnabled=YES;
        _contentScrollView.contentOffset=CGPointMake(self.selectedIndex*kwidth, 0);
        _contentScrollView.showsVerticalScrollIndicator=NO;
        _contentScrollView.showsHorizontalScrollIndicator=NO;
        _contentScrollView.delegate=self;
        _contentScrollView.backgroundColor=[UIColor blackColor];
        [self.view addSubview:_contentScrollView];
    }
    return _contentScrollView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blackColor];
    
    self.title=[NSString stringWithFormat:@"%d/%ld",self.selectedIndex+1,self.images.count];
    
    [self setup];
    
}


-(void)setup{
    
    for (int i=0; i<self.images.count; i++) {
        UIScrollView*picScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(i*self.contentScrollView.frame.size.width, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height)];
        picScrollView.contentSize=CGSizeMake(self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height);
        picScrollView.pagingEnabled=YES;
        picScrollView.delegate=self;
        picScrollView.contentOffset=CGPointMake(0, 0);
        picScrollView.showsVerticalScrollIndicator=NO;
        picScrollView.showsHorizontalScrollIndicator=NO;
        picScrollView.maximumZoomScale=1.0;
        picScrollView.backgroundColor=[UIColor blackColor];
        picScrollView.minimumZoomScale=0.5;
        picScrollView.tag=i+999999;
        [self.contentScrollView addSubview:picScrollView];
        
        UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(2,0, kwidth-4, picScrollView.frame.size.height)];
        iv.contentMode=UIViewContentModeScaleAspectFit;
        iv.tag=i;
        iv.userInteractionEnabled=YES;
        
    
        HomeData*pic=self.images[i];
        [iv sd_setImageWithURL:[NSURL URLWithString:pic.url] placeholderImage:[UIImage imageNamed:@""]];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
        [iv addGestureRecognizer:tap];
        [picScrollView addSubview:iv];
    
    }
    
    UIButton*btn=[UIButton buttonWithImagename:@"delete_image" hightImagename:@"delete_image" bgImagename:@"delete_image" target:self action:@selector(deleteImage:)];
    btn.frame=CGRectMake(kwidth-50, kheight-60-kNavgationBarHeight, 40, 40);
    [self.view addSubview:btn];

}


//-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//        NSLog(@"缩放了。。。。。");
//}
//
//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    return scrollView==self.contentScrollView?nil:(UIImageView*)[self.view viewWithTag:scrollView.tag-999999];
//}




-(void)deleteImage:(UIButton*)sender{

    HomeData*pic=self.images[self.selectedIndex];
    [[DataManager shareManager]deleteDownloadsById:pic._id];
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.selectedIndex=scrollView.contentOffset.x/kwidth;
    self.title=[NSString stringWithFormat:@"%d/%ld",self.selectedIndex+1,self.images.count];
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
