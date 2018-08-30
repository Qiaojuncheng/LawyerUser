//
//  QJMyConsultViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMyConsultViewController.h"
#import "QJMyConsultCell.h"
#import "QJMyConsultModel.h"
#import "QJValuationView.h"
#import "QJMyConsultDetail.h"
@interface QJMyConsultViewController (){
    NSUserDefaults * userdefaults;
    
}

@end

@implementation QJMyConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的咨询";
    //[self makeBackItem];
    userdefaults =[NSUserDefaults standardUserDefaults];
    [self makeUI];
    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)makeData{
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJZIXUN
    NSDictionary * valueDic  = @{@"uid":UserId};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    
     [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
           
            [userdefaults setValue:@"no" forKey:@"MyCounsment"];
            [userdefaults synchronize];
            [dataArray removeAllObjects];
            for (NSDictionary * dic in data[@"data"]) {
                QJMyConsultModel *modle =[QJMyConsultModel yy_modelWithDictionary:dic];
                [modle makeHeight];
                [dataArray addObject:modle];
            }
            
              [_tv reloadData];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        if ( dataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

        
        [self hideHud];
    } failure:^(NSError *error) {
        if ( dataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

        [self hideHud];
        NSLog(@"%@",error);
    }];

}

-(void)makeUI{
    
    dataArray =[NSMutableArray array];
     _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ConentViewWidth , ConentViewHeight ) style:UITableViewStylePlain];
    
    _tv.delegate= self;
    _tv.dataSource= self;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tv];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QJMyConsultModel * model = dataArray[indexPath.row];
    return model.Height;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArray.count;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    QJMyConsultModel * model = dataArray[indexPath.row];

    QJMyConsultDetail * dvc =[[QJMyConsultDetail alloc]initWithNibName:@"QJMyConsultDetail" bundle:[NSBundle mainBundle]];
    dvc.model = model;
     [self.navigationController pushViewController:dvc animated:YES];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    QJMyConsultCell  * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell  == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJMyConsultCell" owner:self options:nil]lastObject] ;
    }
    
    QJMyConsultModel * model = dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle  =  UITableViewCellSelectionStyleNone;
    __weak typeof(self) WeakSelf =self;
    cell.ValuationBlock = ^{
        QJValuationView * valVC =[[QJValuationView alloc]init];
        [valVC show];
        valVC.NUmberSelectBlock = ^(NSString *numberStr) {
            [WeakSelf makePongjiaWithNumber:numberStr Withid:model.rid];
        };
     };
    return cell;
}
-(void)makePongjiaWithNumber:(NSString *)Number Withid:(NSString *)rid{

     NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJPINGJIA
    NSDictionary * valueDic  = @{@"uid":UserId,@"rid":rid,@"star":Number};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self makeData];

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
