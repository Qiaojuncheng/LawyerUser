//
//  WYPingFenViewController.m
//  Lawyer
//
//  Created by yu on 2017/10/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYPingFenViewController.h"
#import "WYJiFenTableViewCell.h"
#import "WYJiFenModel.h"
#import "QJlawyerDetailsViewController.h"
@interface WYPingFenViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *fenTableview;
    int numberss;
    NSMutableArray *listArray;
}

@end

@implementation WYPingFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.title = @"积分公告";
    
    listArray = [NSMutableArray array];
    
    numberss = 0;
    [self makeTableview];
    [self makeJiFenList];
    // Do any additional setup after loading the view.
}
- (void)makeJiFenList{
    numberss ++;
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Indexjf_list
    NSDictionary * valudic;
    valudic  = @{@"page":[NSString stringWithFormat:@"%d",numberss]};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString *status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if ([status isEqualToString:@"0"]) {
            NSArray *Arr =[NSArray arrayWithArray:data[@"data"]];
            if (Arr.count > 0) {
                if (numberss == 1) {
                    [listArray removeAllObjects];
                }else{
                    
                }
                for (NSDictionary *listDic in Arr) {
                    WYJiFenModel *model = [WYJiFenModel yy_modelWithDictionary:listDic];
                    [listArray addObject:model];
                }
                
            }else{
                if (listArray.count == 0) {
                    [self showHint:@"暂无数据！"];
                }else{
                    [self showHint:@"暂无更多数据！"];
                }
                numberss -- ;
            }
        }else{
            numberss -- ;
            [self showHint:@"暂无数据！"];
        }
        
        [fenTableview reloadData];
        [fenTableview.mj_header endRefreshing];
        [fenTableview.mj_footer endRefreshing];
        [self hideHud];
    } failure:^(NSError *error) {
        numberss -- ;
        [fenTableview.mj_header endRefreshing];
        [fenTableview.mj_footer endRefreshing];
        [self hideHud];
        NSLog(@"%@",error);
    }];
}
- (void)makeTableview{
    fenTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    fenTableview.delegate = self;
    fenTableview.dataSource = self;
    fenTableview.tableFooterView = [[UIView alloc]init];
    fenTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        numberss = 0;
        [self makeJiFenList];
    }];
    
    fenTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self makeJiFenList];
    }];
    
    
    [self.view addSubview:fenTableview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYJiFenTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WYJiFenTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.model = listArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    

    
    
    QJlawyerDetailsViewController *detail = [[QJlawyerDetailsViewController alloc]init];
    WYJiFenModel *model = listArray[indexPath.row];
    detail.lawyerID =model.lawyer_id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:NO];
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
