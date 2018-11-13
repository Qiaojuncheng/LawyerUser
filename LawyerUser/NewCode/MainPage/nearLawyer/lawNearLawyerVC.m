//
//  lawNearLawyerVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawNearLawyerVC.h"

#import "lawMainPageLawyerCell.h"
#import "lawLawyerModle.h"
#import "lawLawyerdetailVC.h"

@interface lawNearLawyerVC ()<UITableViewDataSource,UITableViewDelegate>{
 
    
    
     NSInteger page ;
    
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
}


@end

@implementation lawNearLawyerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    page =1 ;
    dataArrray = [[NSMutableArray alloc]init];
    [self addCenterLabelWithTitle:@"附近律师" titleColor:nil];
    
 
    [self makedata];
     [self addView ];
    // Do any additional setup after loading the view.
}

 -(void)makedata{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    LawMaingetLawyerList
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:[NSString stringWithFormat:@"%ld",page ] forKey:@"p" ];
     NSString * log =    [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]?[[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]:@"";
    NSString * lat =   [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"]?[[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"]:@"";
    [valueDic setObject:log forKey:@"lng" ];
    [valueDic setObject:lat forKey:@"lat" ];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    if(page==1){
        [self showHudInView:self.view hint:nil];
    }
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if (page ==1) {
            [dataArrray removeAllObjects];
        }
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            
            for (NSDictionary * dics in data[@"data"]) {
                lawLawyerModle * model =  [lawLawyerModle yy_modelWithDictionary:dics];
                [dataArrray addObject:model];
                
            }
            
            [_tableView reloadData];
        }
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
    
}
-(void)addView{
    self.view.backgroundColor = [UIColor colorWithHex:0xf7f7f7];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight   , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  ) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.mj_header  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        page = 1;
        [self makedata];
    }];
    _tableView.mj_footer =[MJRefreshAutoFooter   footerWithRefreshingBlock:^{
        page += 1;
        [self makedata];
        
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    
    
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    lawMainPageLawyerCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawMainPageLawyerCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.DistanceLB.text = cell.model.distance;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    lawLawyerdetailVC * detail =[[lawLawyerdetailVC alloc]init];
    lawLawyerModle * model = dataArrray[indexPath.row];
    detail.lawyerid = model.id;
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108 ;
    
}
-(void)viewWillAppear:(BOOL)animated{
    //    if(!IsLogin){
    //        LawLogionViewController *view = [LawLogionViewController new];
    //        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
    //        [UIApplication sharedApplication].delegate.window.rootViewController = na;
    //        return ;
    //    }
    
}


  #pragma mark - Navigation
 

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
