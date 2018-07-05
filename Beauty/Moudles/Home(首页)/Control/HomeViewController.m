//
//  HomeViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/4.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeData.h"
#import "HomeTool.h"
#import "topScrollView.h"
#import "HomeCell.h"
#import "topicCell.h"
#import "ArticleCell.h"

@interface HomeViewController ()<TopScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray*data;
@property(nonatomic,strong)topScrollView*topView;
@property(nonatomic,copy)NSString*type;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)UIButton*floatBtn;

@end

@implementation HomeViewController

-(UIButton *)floatBtn{
    if (!_floatBtn) {
        _floatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _floatBtn.frame=CGRectMake(kwidth-60, kheight-kTabbarHeight-kNavgationBarHeight, 50, 50);
        _floatBtn.hidden=YES;
        [_floatBtn addTarget:self action:@selector(refreshTableViewData) forControlEvents:UIControlEventTouchUpInside];
        [_floatBtn setBackgroundImage:[UIImage imageNamed:@"top_scroll"] forState:UIControlStateNormal];
    }
    return _floatBtn;
}

-(NSMutableArray *)data{
    if (!_data) {
        _data=[NSMutableArray new];
    }
    return _data;
}

-(topScrollView *)topView{
    if (!_topView) {
        _topView=[[topScrollView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 40)];
        _topView.delegate=self;
    }
    return _topView;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 41, kwidth, kheight-41-kTabbarHeight-kNavgationBarHeight) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDown)];
        _tableview.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshUp)];
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableview;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.floatBtn.hidden=YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"干货";
    self.type=@"all";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableview];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self refreshDown];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableViewData) name:@"MainTabBarDidClickNotification" object:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:self.floatBtn];
    
    
    
    

}

-(void)refreshTableViewData{
    [self.tableview.mj_header beginRefreshing];
    [self refreshDown];
}

//下拉刷新
- (void)refreshDown{
    self.page = 1;
    [self loadHomeData];
}
//上拉加载
- (void)refreshUp{
    self.page +=1;
    [self loadHomeData];
}

-(void)loadHomeData{
    
    HomeTool*tool=[[HomeTool alloc]init];
    tool.page=self.page;
    tool.type=self.type;
    [tool getHomeDataSuccess:^(id list) {
        HomeDataResult*r=(HomeDataResult*)list;
        if (self.page== 1){
            [self.data removeAllObjects];
        }
        [self.data addObjectsFromArray:r.results];
        NSLog(@"%@返回的数据%@",self.type,self.data);

        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];

    } AndFailure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeData*data=self.data[indexPath.row];
    if (data.images.count>0) {
        if (data.images.count>=3) {
            HomeCell*cell=[HomeCell configCellWithTableView:self.tableview];
            cell.data=data;
            return cell;
        }else{
            topicCell*cell=[topicCell configCellWithTableView:self.tableview];
            cell.data=data;
            return cell;
        }
    }else{
        ArticleCell*cell=[ArticleCell configCellWithTableView:self.tableview];
        cell.data=data;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeData*data=self.data[indexPath.row];
    return data.images.count>=3?190:100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeData*model=self.data[indexPath.row];
    BaseWebViewController*web=[[BaseWebViewController alloc]init];
    web.html=model.url;
    web.name=@"Gank";
    [self.navigationController pushViewController:web animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y>kTabbarHeight) {
        self.floatBtn.hidden=NO;
    }else{
        self.floatBtn.hidden=YES;
    }
}


#pragma mark topViewDelegate
-(void)topScrollView:(topScrollView *)scrollView DidFinishSelectAtIndexType:(NSString *)type{
    self.type=type;
    [self.tableview.mj_header beginRefreshing];
    [self refreshDown];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
