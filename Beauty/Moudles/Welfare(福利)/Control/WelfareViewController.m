//
//  WelfareViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareTool.h"
#import "WelfareCell.h"
#import "WaterFlowLayout.h"
#import "PopView.h"

@interface WelfareViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>

@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray*data;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WelfareViewController

-(NSMutableArray *)data{
    if (!_data) {
        _data=[NSMutableArray new];
    }
    return _data;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
        CGRect frame=CGRectMake(0, 0, kwidth, kheight-kTabbarHeight-kNavgationBarHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate=self;
        layout.delegate=self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WelfareCell class]) bundle:nil] forCellWithReuseIdentifier:@"WelfareCell"];
        _collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDown)];
        _collectionView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshUp)];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"福利";
    [self.view addSubview:self.collectionView];
    [self refreshDown];

}
//下拉刷新
- (void)refreshDown{
    self.page = 1;
    [self loadData];
}
//上拉加载
- (void)refreshUp{
    self.page +=1;
    [self loadData];
}

/*加载数据源*/
-(void)loadData{
    
    WelfareTool *tool=[[WelfareTool alloc]init];
    tool.page=self.page;
    [tool getWelfareDataSuccess:^(id list) {
        WelfareResult*r=(WelfareResult*)list;
        NSLog(@"返回来的数据---%@",r.results);
        if (self.page== 1){
            [self.data removeAllObjects];
        }
            [self.data addObjectsFromArray:r.results];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
    } AndFailure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WelfareCell" forIndexPath:indexPath];
    cell.model = self.data[indexPath.item];
    return cell;
}
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth{
    return (kwidth>320?180:120 )+ arc4random_uniform(120);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WelfareModel*model=self.data[indexPath.row];
    NSLog(@"点击的是:%@---id=%@",model.createdAt,model._id);
    
    PopView*pop=[[PopView alloc]init];
    pop.welfare=self.data[indexPath.row];
    [self presentViewController:pop animated:NO completion:nil];    


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
