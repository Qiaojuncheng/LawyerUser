//
//  lawMyconsultDetailVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyconsultDetailVC.h"
#import "lawMyConsultCell.h"
#import "lawMyConsultDetailCell.h"
#import "lawConsultdetailModel.h"
#import "lawFindSendHeaderVC.h"
#import "lawLawyerdetailVC.h"
@interface lawMyconsultDetailVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
}



@end

@implementation lawMyconsultDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    dataArrray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
    
    [self addCenterLabelWithTitle:@"咨询详情" titleColor:nil];
    [self addView];
    [self makeCollect];
    // Do any additional setup after loading the view.
}
-(void)makeCollect{
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        NewmymyconsultXq
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if( IsLogin){
        [valuedic setValue:UserId forKey:@"uid"];
        [valuedic setValue:self.ConstulId forKey:@"id"];

        [valuedic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
        
        NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
        
        [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
            [self hideHud];
            // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
                if (page == 1) {
                    [dataArrray removeAllObjects];
                    self.model =[lawMyconsultListModel yy_modelWithJSON:responseObjeck[@"data"]];
                    self.model.CellHeight =[NSString GetHeightWithMaxSize:CGSizeMake(SCREENWIDTH - 35, MAXFLOAT) AndFont:[UIFont systemFontOfSize:15] AndText:self.model.content].height +100;
                    self.model.red =@"1";
                }
                
                
                for (NSDictionary  * dicc in responseObjeck[@"data"][@"reply_list"]) {
                    
                    
                    
                    lawConsultdetailModel * model = [ lawConsultdetailModel yy_modelWithJSON:dicc];
                    model.CellHeight =[NSString GetHeightWithMaxSize:CGSizeMake(SCREENWIDTH - 68, MAXFLOAT) AndFont:[UIFont systemFontOfSize:15] AndText:model.content].height +90;
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
        return   dataArrray.count;
        
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return 10;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc]init];
    }else{
        UIView * HeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        HeaderView.backgroundColor =[UIColor colorWithHex:0xf7f7f7];
        return  HeaderView;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==0){
        lawMyConsultCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawMyConsultCell" owner:self options:nil]lastObject];
        }
        cell.Model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
    }else{
        lawMyConsultDetailCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"decell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawMyConsultDetailCell" owner:self options:nil]lastObject];
        }
        cell.model=  dataArrray[indexPath.row];
        cell.BtnActionBlock = ^(int index) {
            lawConsultdetailModel * detailmodel =  dataArrray[indexPath.row];

            if(index == 31){
                //        采纳
                [self getConsonslutWithIndex:indexPath.row];
            }else if (index ==32){
                //        送心意
                
                lawFindSendHeaderVC * sendHeader = [[lawFindSendHeaderVC alloc]init];
                
                lawLawyerDetailModle *model = [[lawLawyerDetailModle alloc]init];
                model.name = detailmodel.lawyer_name;
                model.id  = detailmodel.lid;
                model.avatar = detailmodel.avatar ;
                sendHeader.model = model;
                [self.navigationController pushViewController:sendHeader animated:YES];
            }else if(index == 33){
                //        咨询
                lawLawyerdetailVC * detail =[[lawLawyerdetailVC alloc]init];
                 detail.lawyerid = detailmodel.lid;
                [self.navigationController pushViewController:detail animated:YES];
            }

        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.model.CellHeight?self.model.CellHeight:0;
    }else{
        lawConsultdetailModel *model =  dataArrray[indexPath.row];
        return model.CellHeight;
    }
}
 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat sectionHeaderHeight = 30;
        if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
            } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                    scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
                }
}
// 采纳
-(void)getConsonslutWithIndex:(NSInteger)index{
    
    lawConsultdetailModel * detailmodel =  dataArrray[index];

         [self showHudInView:self.view hint:nil];
     NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    Newmyuseradopt
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if( IsLogin){
        [valuedic setValue:UserId forKey:@"uid"];
        [valuedic setValue:self.model.id forKey:@"cid"];
        [valuedic setValue:detailmodel.id forKey:@"id"];

 
        NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
        
        [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
            [self hideHud];
            // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
                [self showHint:responseObjeck[@"msg"]];

                page = 1 ;
                [self makeCollect];
            }
          
         } failure:^(NSError *error) {
            [self hideHud];
         }];
        
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
