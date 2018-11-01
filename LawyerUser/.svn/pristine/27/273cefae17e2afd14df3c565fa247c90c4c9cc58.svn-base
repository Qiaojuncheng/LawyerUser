//
//  QJLawyerLC.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/29.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJLawyerLC.h"
#import "QJLawyerModle.h"
#import "QJLawyerListCell.h"
#import "QJPayViewController.h"
@interface QJLawyerLC (){
    QJLawyerModle *selectModel;

}

@end

@implementation QJLawyerLC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"律师列表";
    DataArray = [NSMutableArray array];
    [self makeUI];
    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)makeData{
    
    DataArray =[[NSMutableArray alloc]init];
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJGETLAWYERLIST
    NSDictionary * valueDic  = @{@"user_id":UserId,@"type":self.Type,@"id":self.ID};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            for (NSDictionary * dic in data[@"data"]) {
                QJLawyerModle *model =[QJLawyerModle yy_modelWithDictionary:dic];
                [DataArray addObject:model];
            }
            [_tv reloadData];
        }else{
//            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
//            [self showHint:msg];
        }
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无律师抢单" yOffset:0];
        }else{
            [self hintNodataView];
        }
        
     } failure:^(NSError *error) {
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无律师抢单" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

        NSLog(@"%@",error);
    }];
    
    
}
-(void)makeUI{
    
    
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.delegate = self;
    _tv.dataSource= self;
    
    _tv.tableFooterView =[[UIView alloc]init];
    
    [self.view addSubview:_tv];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return   164;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QJLawyerListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QJLawyerListCell" owner:self
                                            options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QJLawyerModle * model =DataArray[indexPath.row];
    cell.pingyongBtn.tag = indexPath.row;
    [cell.pingyongBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = model;
    return  cell;
}
- (void)didButton:(UIButton *)sender{
    
    selectModel = DataArray[sender.tag];
    [self makeAddAction];
}
- (void)makeAddAction{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息" message:@"聘用付款之后，就无法更改，请慎重选择！" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"律师列表点击了确定！");
        [self PingyongLawyer];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"律师列表点击了取消！");
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)PingyongLawyer{


    
     
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    DOOPEARE
    NSDictionary * valueDic  = @{@"user_id":UserId,@"type":self.Type,@"offer_id":selectModel.offer_id};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
/*
 data =     {
 offer =         {
 "create_time" = 0;
 "entr_id" = 30;
 "finish_time" = 1577808000;
 id = 53;
 "lawyer_id" = 5;
 "order_id" = 30;
 price = "5000.00";
 status = 0;
 type = 4;
 "user_money" = "89969579.99";
 };
 };
 msg = ok;
 status = 0;
 }

 */
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.title = @"聘用律师支付";
            pavVc.payType = @"3";
            pavVc.payPrice= data[@"data"][@"offer"][@"price"];
            pavVc.payID = data[@"data"][@"offer"][@"entr_id"];
            pavVc.BuyConcent = data[@"data"][@"offer"][@"user_money"];
            pavVc.PinYongType = self.Type;
            pavVc.PinYongoffer_id = data[@"data"][@"offer"][@"id"];
            pavVc.PinYongoffer_ordersn = data[@"data"][@"offer"][@"order_sn"];
            pavVc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:pavVc animated:YES];
            

         }
        
    } failure:^(NSError *error) {
         NSLog(@"%@",error);
    }];
    

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
