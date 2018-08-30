//
//  QJMySetMealVC.m
//  Lawyer
//
//  Created by MYMAc on 2017/8/8.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMySetMealVC.h"
#import "QJVipVc.h"
#import "QJTaoCanCell.h"
#import "QJTaocanModel.h"
@interface QJMySetMealVC ()<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray * DataArray;
    UITableView *  _TV ;
}

@end

@implementation QJMySetMealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.JiaoFeiBtton createBordersWithColor:nil withCornerRadius:4 andWidth:0];
    self.title = @"我的套餐";
    DataArray = [[NSMutableArray alloc]init];
    QJTaocanModel *model  =[[QJTaocanModel alloc]init];
    model.now_num = @"剩余次数";
    model.level_name = @"项目";
    model.price = @"Price";
    [DataArray addObject:model];

    [self makeUI];
    [self makeTaoCanData];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)makeUI{

    _TV =[[UITableView alloc]initWithFrame:CGRectMake(10, 74 , ConentViewWidth - 20  ,ConentViewHeight - 74 -10) style:UITableViewStylePlain];
    _TV.delegate= self;
    _TV.dataSource = self;
    UIView * view =[[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHex:0xececec];
    _TV.tableFooterView =view;
    _TV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TV.showsVerticalScrollIndicator  = NO;
    _TV.layer.masksToBounds = YES;
    _TV.layer.cornerRadius = 3;
    [self.view addSubview:_TV];

}
-(void)makeTaoCanData{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJWDTC
    NSDictionary * valueDic  = @{@"uid":UserId};
    //    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
         NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
           
            //  is_member 1 是会员  0  不是会员
 
            NSString * is_member = [NSString stringWithFormat:@"%@",data[@"data"][@"is_member"]];
            if ([is_member isEqualToString:@"1"]) {
                _Myleve_name.text = [NSString stringWithFormat:@"    我的等级:%@",data[@"data"][@"user_suit"][@"level_name"]];
                [self.JiaoFeiBtton setTitle:@" 去购买套餐 " forState:UIControlStateNormal];
            }else{
                _Myleve_name.text = [NSString stringWithFormat:@"    未购买套餐"];
                [self.JiaoFeiBtton setTitle:@"  去购买套餐  " forState:UIControlStateNormal];
            }
            
            for (NSDictionary * dic in data[@"data"][@"type"]) {
                QJTaocanModel * model =  [QJTaocanModel yy_modelWithJSON:dic];
                [DataArray addObject:model];
            }
            if (_TV.height > 50 * DataArray.count) {
                _TV.height  = 50 * DataArray.count;
            }
            [_TV reloadData];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJTaoCanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJTaoCanCell" owner:self options:nil]lastObject];
        
    }
    cell.model = DataArray[indexPath.row];
    return  cell;
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

- (IBAction)JiaoFeiAction:(id)sender {
    
    QJVipVc * sevc =[[QJVipVc alloc]init];
    [self.navigationController pushViewController:sevc animated:YES];
}
@end
