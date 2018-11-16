//
//  lawVipRecodeVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/3.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipRecodeVC.h"
#import "lawVipRecodeModel.h"
#import "lawMinVipUerCell.h"
#import "lawVipRechargeCell.h"
@interface lawVipRecodeVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
}



@end

@implementation lawVipRecodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.RecodeType isEqualToString:@"1"]) {
        [self addCenterLabelWithTitle:@"使用记录" titleColor:nil];
    }else{
        [self addCenterLabelWithTitle:@"充值记录" titleColor:nil];
    }
    page = 1;
    dataArrray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
    
     [self addView];
    [self makeRecode];

    // Do any additional setup after loading the view.
}

-(void)makeRecode{
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
     }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    if ([self.RecodeType isEqualToString:@"1"]) {
    NewUserLogs
    }else{
        NewUserrechargeLogs
    }
    
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if( IsLogin){
        [valuedic setValue:UserId forKey:@"uid"];
         [valuedic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
         NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
        
        [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
            [self hideHud];
            // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
                if (page == 1) {
                    [dataArrray removeAllObjects];
                }
                for (NSDictionary  * dicc in responseObjeck[@"data"]) {
                    
                    lawVipRecodeModel * model = [lawVipRecodeModel yy_modelWithJSON:dicc];
                    [dataArrray addObject:model];
                    
                }
                [_tableView reloadData];
            }
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            
        } failure:^(NSError *error) {
            [self hideHud];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }];
        
    }
    
}

-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 10 , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  - 10) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        
        [weakSelf makeRecode];
    }];
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    
    
    
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf makeRecode];
    }];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.RecodeType isEqualToString:@"1"]) {
        lawMinVipUerCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"lawMinVipUerCell" owner:self options:nil]lastObject];
        }
        cell.model= dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else{
        
        lawVipRechargeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"lawVipRechargeCell" owner:self options:nil]lastObject];
        }
        cell.model= dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
 
    }
    
 }
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     if ([self.RecodeType isEqualToString:@"1"]) {
         return  100;
     }else{
         return  141;
     }
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
