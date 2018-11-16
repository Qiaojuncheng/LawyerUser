//
//  lawPhoneAppointVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPhoneAppointVC.h"
#import "lawPhoneAppointCell.h"
#import "lawAppointModel.h"

@interface lawPhoneAppointVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
}

@end

@implementation lawPhoneAppointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    dataArrray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
    
    [self addCenterLabelWithTitle:@"电话咨询" titleColor:nil];
    [self addView];
    [self makeCollect];
    // Do any additional setup after loading the view.
}
-(void)makeCollect{
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        NewmyusermyAppoint
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if( IsLogin){
        [valuedic setValue:UserId forKey:@"uid"];
        [valuedic setValue:@"1" forKey:@"type"];
        [valuedic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
        if(self.mid){
            [valuedic setValue:self.mid forKey:@"mid"];
        }
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
                    
                    lawAppointModel * model = [lawAppointModel yy_modelWithJSON:dicc];
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
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  ) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        
        [weakSelf makeCollect];
    }];
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    
    
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf makeCollect];
    }];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return   dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    lawPhoneAppointCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawPhoneAppointCell" owner:self options:nil]lastObject];
    }
    cell.model =dataArrray[indexPath.row];
    cell.OverBlock = ^{
        [self  overWihtIndex:indexPath.row];
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.MeetAddresLB.hidden = YES;
    cell.TopHeight.constant = 27;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  163;
}
-(void)overWihtIndex:(NSInteger)index{
    lawAppointModel * model = dataArrray[index];
    
    UIAlertController * ALVc =[UIAlertController alertControllerWithTitle:@"" message:@"此操作将结束本次咨询服务， 请确保咨询已经完成！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * canaction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * SureAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showHudInView:self.view hint:nil];
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        NewmyusermyAppointOver
        NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
        if( IsLogin){
            [valuedic setValue:UserId forKey:@"uid"];
            [valuedic setValue:model.id  forKey:@"id"];
            NSString * base64String =[NSString getBase64StringWithArray:valuedic];
            [dic setValue:base64String forKey:@"value"];
            
            [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
                [self hideHud];
                // 处理数据
                if ([responseObjeck[@"status"] integerValue] == 0) {
                    model.status = @"5";
                    [dataArrray replaceObjectAtIndex:index withObject:model];
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
    }];
    [ALVc addAction:canaction];
    [ALVc addAction:SureAction];
    [self presentViewController:ALVc animated:YES completion:nil];
    
 
    
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
