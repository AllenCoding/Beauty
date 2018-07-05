//
//  DownloadViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "DownloadViewController.h"
#import "WaterFlowLayout.h"
#import "WelfareCell.h"
#import "PopView.h"
#import "CustomImageBrowser.h"

@interface DownloadViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)NSArray*data;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DownloadViewController


//-(NSMutableArray *)data{
//    if (!_data) {
//        _data=[NSMutableArray new];
//    }
//    return _data;
//}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
        CGRect frame=CGRectMake(0, 0, kwidth, kheight-kNavgationBarHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate=self;
        _collectionView.emptyDataSetSource=self;
        _collectionView.emptyDataSetDelegate=self;
        layout.delegate=self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WelfareCell class]) bundle:nil] forCellWithReuseIdentifier:@"WelfareCell"];
    }
    return _collectionView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self loadData];

}

///*加载数据源*/
-(void)loadData{
    self.data=[[DataManager shareManager]downloads];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WelfareCell" forIndexPath:indexPath];
    cell.data = self.data[indexPath.item];
    return cell;
}
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth{
    return (kwidth>320?180:120 )+ arc4random_uniform(120);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomImageBrowser*browser=[[CustomImageBrowser alloc]initWithimages:self.data andSelectedImageIndex:(int)indexPath.item];
    [self.navigationController pushViewController:browser animated:YES];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"empty_default"];
}
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSAttributedString *string=[[NSAttributedString alloc]initWithString:@"你还没有下载过哦~" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return string;
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
