//
//  lawMyOrderDetailVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyOrderDetailVC.h"
#import "lawMyOrderListCell.h"
#import "lawMyOrderDetailCell.h"
@interface lawMyOrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
}


@end

@implementation lawMyOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    dataArrray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
    
    [self addCenterLabelWithTitle:@"服务详情" titleColor:nil];
    [self addView];
    [self makeCollect];
    // Do any additional setup after loading the view.
}
-(void)makeCollect{
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    //    NewCasemyCollect
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
                    
                    //                    LawCaseNewModel * model = [LawCaseNewModel yy_modelWithJSON:dicc];
                    //                    [dataArrray addObject:model];
                    
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
    _tableView.separatorInset = UIEdgeInsetsMake(0,30, 0, 30);
    _tableView.separatorColor =[UIColor colorWithHex:0xE5E5E5];
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
    if (section == 0) {
        return 1;
    }else{
        return  10;// dataArrray.count;

    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return 30;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc]init];
    }else{
        UIView * HeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
        HeaderView.backgroundColor =[UIColor colorWithHex:0xf7f7f7];
        return  HeaderView;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==0){
    lawMyOrderListCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawMyOrderListCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
    }else{
        lawMyOrderDetailCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"decell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawMyOrderDetailCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;

        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 197;
    }else{
        return 100;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat sectionHeaderHeight = 30;
        if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
            } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                    scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
