//
//  QJAppointmentViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJAppointmentViewController.h"
#import "QJAppointmentCell.h"
#import "QJAppontmentModel.h"
#import "QJViewController.h"
@interface QJAppointmentViewController (){
    NSInteger Page;
    NSUserDefaults * UserDefaults;
}

@end

@implementation QJAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的预约";
    UserDefaults = [NSUserDefaults standardUserDefaults];
    Page =1;
    //[self makeBackItem];
    DataArray  =[[NSMutableArray alloc]init];
 
    
    [self makeUI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self makeYuyueData];


}

-(void)makeYuyueData{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    BOOKLIST
    NSDictionary * valueDic  = @{@"user_id":UserId,@"p":[NSString stringWithFormat:@"%ld",(long)Page]};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [UserDefaults setValue:@"no" forKey:@"MyAppoinment"];
            [UserDefaults synchronize];
            if (Page ==1) {
                [DataArray removeAllObjects];
            }
            
            for (NSDictionary * dic in data[@"data"]) {
                QJAppontmentModel * model =[QJAppontmentModel yy_modelWithDictionary:dic];
                [DataArray addObject:model];
            }
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [_tv reloadData];

        [_tv.mj_footer endRefreshing];
        [_tv.mj_header endRefreshing];
        [self hideHud];
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

    } failure:^(NSError *error) {
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        

        [self hideHud];
        [_tv.mj_footer endRefreshing];
        [_tv.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
    
}

-(void)makeUI{

    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth ,ConentViewHeight) style:UITableViewStylePlain];
    
    _tv.dataSource= self;
    _tv.delegate= self;
    _tv.tableFooterView =[[UIView alloc]init];

    _tv.mj_header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Page  =1;
        [self makeYuyueData];

    }];
    
    _tv.mj_footer  =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        Page ++;
        [self makeYuyueData];

    }];
    
    
    [self.view addSubview:_tv];



}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return DataArray.count;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJAppointmentCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"QJAppointmentCell" owner:self options:nil]lastObject];
    }

    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    QJAppontmentModel *modle =DataArray[indexPath.row];
    cell.model = modle;
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       QJAppontmentModel *modle =DataArray[indexPath.row];
              QJViewController * JVC =[[QJViewController alloc]init];
           JVC.model=  modle;
           [self.navigationController pushViewController:JVC animated:YES];
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
