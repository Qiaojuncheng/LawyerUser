//
//  QJNeedsWenShuVC.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNeedsWenShuVC.h"
#import "QJNeedModel.h"
#import "QJNeedCell.h"
#import "QJLawyerLC.h"
#import "QJValuationView.h"

@interface QJNeedsWenShuVC (){
    
    NSInteger PageNumber;
}

@end

@implementation QJNeedsWenShuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    PageNumber = 1;
    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)makeData{

    DataArray =[[NSMutableArray alloc]init];
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJWDXQ
    NSDictionary * valueDic  = @{@"uid":UserId,@"type":[NSString stringWithFormat:@"1"],@"p":[NSString stringWithFormat:@"%ld",PageNumber]};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if (PageNumber == 1) {
            [DataArray removeAllObjects];
        }
        
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
              for (NSDictionary * dic in data[@"data"][@"list"]) {
                  QJNeedModel *model =[QJNeedModel yy_modelWithDictionary:dic];
                  [DataArray addObject:model];
              }
            [_tv reloadData];
        }else{
//            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
//            [self showHint:msg];
        }
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

        [_tv.mj_header endRefreshing];
        [_tv.mj_footer endRefreshing];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [_tv.mj_header endRefreshing];
        [_tv.mj_footer endRefreshing];
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

        NSLog(@"%@",error);
    }];


}
-(void)makeUI{


    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight - 42) style:UITableViewStylePlain];
    _tv.delegate = self;
    _tv.dataSource= self;
    
    _tv.tableFooterView =[[UIView alloc]init];
    _tv.mj_header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        PageNumber = 1;
        [self makeData];
    }];
    _tv.mj_footer  =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        PageNumber ++;
        [self makeData];
    }];
    
    [self.view addSubview:_tv];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return  DataArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return   210;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJNeedCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QJNeedCell" owner:self
                                            options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QJNeedModel * model =DataArray[indexPath.row];
    cell.modle = model;
    __weak typeof(self) WeakSelf = self;

    cell.SeleBlock = ^(BOOL Pingjia) {
        if (Pingjia) {
            QJValuationView * valVC =[[QJValuationView alloc]init];
            [valVC show];
            valVC.NUmberSelectBlock = ^(NSString *numberStr) {
                [WeakSelf makePongjiaWithNumber:numberStr Withid:model.id];
            };
            
        }else{
            [self pushLawyerListWithId:model.id];
        }
    };
    return  cell;
}
-(void)makePongjiaWithNumber:(NSString *)Number Withid:(NSString *)rid{
    
    [self showHint:@""];
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJMYXQ_PINGJIA
    NSDictionary * valueDic  = @{@"uid":UserId,@"id":rid,@"star":Number,@"type":@"3"};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self showHint:@"评价成功！"];

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
    
}


-(void)pushLawyerListWithId:(NSString *)needid{

    QJLawyerLC * pvc =[[QJLawyerLC alloc]init];
    
    pvc.ID= needid;
    pvc.Type = @"3";
     [self.navigationController pushViewController:pvc animated:YES];

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
