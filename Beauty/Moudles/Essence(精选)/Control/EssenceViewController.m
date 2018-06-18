//
//  EssenceViewController.m
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "EssenceViewController.h"
#import "ArticleCell.h"
#import "EssenceTool.h"
#import "EssenceCell.h"
#import "TypeView.h"

@interface EssenceViewController ()<UITableViewDelegate,UITableViewDataSource,TypeViewDelegate>
@property(nonatomic,strong)NSMutableArray*data;
@property(nonatomic,copy)NSString*type;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,assign)int page;

@end

@implementation EssenceViewController

-(NSMutableArray *)data{
    if (!_data) {
        _data=[NSMutableArray new];
    }
    return _data;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight-kTabbarHeight-kNavgationBarHeight) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDown)];
        _tableview.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshUp)];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type=@"App";
    self.navigationItem.title=[NSString stringWithFormat:@"%@精选",self.type];
    [self.view addSubview:self.tableview];
    [self refreshDown];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIBarButtonItem*item=[UIBarButtonItem itemWithImagename:@"selection_type" hightImagename:@"selection_type" target:self action:@selector(chooseType:)];
    self.navigationItem.rightBarButtonItem=item;
}

-(void)chooseType:(UIButton*)sender{
    TypeView*tv=[[TypeView alloc]init];
    tv.delegate=self;
    [self presentViewController:tv animated:YES completion:nil];
}


-(void)didSelectType:(NSString *)type{
    self.type=type;
    [self.tableview.mj_header beginRefreshing];
    [self refreshDown];
    self.navigationItem.title=[NSString stringWithFormat:@"%@精选",self.type];
    
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


-(void)loadData{
    
    EssenceTool*tool=[[EssenceTool alloc]init];
    tool.page=self.page;
    tool.type=self.type;
    [tool getEssenceDataSuccess:^(id list) {
        EssenceResult*r=(EssenceResult*)list;
        if (self.page== 1){
            [self.data removeAllObjects];
        }
        [self.data addObjectsFromArray:r.results];
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
        EssenceCell*cell=[EssenceCell configCellWithTableView:self.tableview];
        cell.data=data;
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeData*model=self.data[indexPath.row];
    BaseWebViewController*web=[[BaseWebViewController alloc]init];
    web.html=model.url;
    web.name=@"Gank";
    [self.navigationController pushViewController:web animated:YES];
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
