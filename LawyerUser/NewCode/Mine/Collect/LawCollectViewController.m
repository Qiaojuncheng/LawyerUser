//
//  LawCollectViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCollectViewController.h"
#import "LawCaseCell.h"
#import "LawCaseAppreciateDetail.h"
#import "lawCollectLawyerCell.h"
#import "lawCollecLawyerModel.h"
#import "lawLawyerdetailVC.h"

@interface LawCollectViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
    NSString * type ;// 1 文章   2 律师
    UIView * lineVIew;
    UIButton * tempBtm;
}

@end

@implementation LawCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    type = @"1";
    dataArrray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
   
    [self addCenterLabelWithTitle:@"我的收藏" titleColor:nil];
    [self addView];
    [self makeCollect];
    // Do any additional setup after loading the view.
}
-(void)makeCollect{
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewmyCollect
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if( IsLogin){
        [valuedic setValue:UserId forKey:@"uid"];
         [valuedic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
        [valuedic setValue:[NSString stringWithFormat:@"%@",type] forKey:@"type"];
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
                    if([type isEqualToString:@"1"]){
                        LawCaseNewModel * model = [LawCaseNewModel yy_modelWithJSON:dicc];
                        [dataArrray addObject:model];

                    }else{
                        lawCollecLawyerModel * model = [lawCollecLawyerModel yy_modelWithJSON:dicc];
                        [dataArrray addObject:model];

                        
                    }

                    
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
    
//     顶部VIew
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, 40)];
    headerView.backgroundColor =[UIColor whiteColor];
    lineVIew =[[UIView alloc]initWithFrame:CGRectMake(0, 38, 40, 2)];
    lineVIew.backgroundColor =[UIColor colorWithHex:0x3181FE];
    [headerView addSubview:lineVIew];
    for (int i =0; i <  2; i++) {
        UIButton * titleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(SCREENWIDTH/2 * i, 0, SCREENWIDTH/2, 38);
        if(i == 0){
            [titleBtn setTitle:@"案例" forState:UIControlStateNormal];
            lineVIew.centerX = titleBtn.centerX;
            tempBtm  =  titleBtn;
            titleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
            [titleBtn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        }else{
            [titleBtn setTitle:@"律师" forState:UIControlStateNormal];        titleBtn.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:16];
            [titleBtn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];

         }
        titleBtn.tag = 30+i;
        [titleBtn addTarget:self action:@selector(ChangeDataType:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:titleBtn];
    }
    
    
    UIView * Gronyview =[[UIView alloc]initWithFrame:CGRectMake(0, 39, SCREENWIDTH, 1)];
    Gronyview.backgroundColor =[UIColor colorWithHex:0xf5f5f5];
    [headerView addSubview:Gronyview];
    [self.view addSubview:headerView];
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  headerView.bottom  , SCREENWIDTH, SCREENHEIGHT  -   headerView.bottom) style:UITableViewStylePlain];
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
-(void)ChangeDataType:(UIButton * )sender{
    tempBtm.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [tempBtm setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [sender setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];

    tempBtm = sender;
    
    if(tempBtm.tag == 30){
        type = @"1";
    }else{
        type =@"2";
    }
    page = 1;
    [self makeCollect];
    [UIView animateWithDuration:0.3 animations:^{
        lineVIew.centerX = tempBtm.centerX;
    }];
    
}

 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([type isEqualToString:@"1"]) {
        LawCaseCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawCaseCell" owner:self options:nil]lastObject];
        }
        cell.model = dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
    }else{
        
        lawCollectLawyerCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawCollectLawyerCell" owner:self options:nil]lastObject];
        }
        cell.model = dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([type isEqualToString:@"1"]) {
    
    LawCaseNewModel *  model = dataArrray[indexPath.row];
    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
    detail.model = model;
     detail.ChangCollectStatus = ^(NSString *iscollect) {
        model.is_collect = iscollect;
        [dataArrray replaceObjectAtIndex:indexPath.row withObject:model];
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:detail animated:YES];
    }else {
        lawLawyerdetailVC * detail =[[lawLawyerdetailVC alloc]init];
        lawCollecLawyerModel * model = dataArrray[indexPath.row];
        detail.lawyerid = model.id;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([type isEqualToString:@"1"]) {
        return 120;

    }else{
        return  80;
    }
    
}
- (NSString *)xy_noDataViewMessage {
    return @"暂无收藏";
}

- (UIImage  *)xy_noDataViewImage{
    return  [UIImage imageNamed:@"tips_nocollect"];
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
