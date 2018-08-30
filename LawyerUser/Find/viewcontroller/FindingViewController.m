//
//  FindingViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "FindingViewController.h"
#import "QJMapSearchViewController.h"
#import "JSDropDownMenu.h"
#import "WYFindTableViewCell.h"
#import "QJlawyerDetailsViewController.h"
#import "WYFindViewModel.h"

#import "QJSelectArea.h"
#import "QJSelectDatePickView.h"

@interface FindingViewController ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>{
    UISegmentedControl * sg;
    JSDropDownMenu *menu;
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    NSString *lid;
    NSString *tid;
    NSString *areaId;
    NSString *CityName;
    NSMutableArray *listArr;
    int numbers;
    
    UIButton * rightBtn;
    QJSelectArea * selectAreaPick;//地区选择视图
    QJSelectDatePickView * selectPick;
    NSString *AreaStr;
    NSUserDefaults * userdefautlt;
//    NSMutableDictionary * valueDicing;
}

@end

@implementation FindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    userdefautlt  =[NSUserDefaults standardUserDefaults];
    areaId = @"";

    CityName =[NSString changeNullString:[userdefautlt objectForKey:@"cityName"]];
    if (CityName.length == 0) {
        CityName = @"区域";
    }

    areaId = [NSString changeNullString:[ userdefautlt  objectForKey:@"AreaId"]];
     rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 70, 30);
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [rightBtn setTitle:CityName forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(RightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    DataArray = [NSMutableArray array];
    listArr = [NSMutableArray array];
    lid = @"";
    tid = @"";
    
    numbers = 0;
    
    [self makeTV];
    
    [self makeAppLawyerFinds];
    [self makeLeiBieList];
    [self makeSegment];
    [self maketopItem];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    CityName =[NSString changeNullString:[userdefautlt objectForKey:@"cityName"]];
    if (CityName.length == 0) {
        CityName = @"区域";
    }
    [rightBtn setTitle:CityName forState:UIControlStateNormal];

}
-(void)RemoveVIew:(UIButton *)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        selectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        [selectAreaPick removeFromSuperview];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    rightBtn.selected = NO;
    [selectAreaPick removeFromSuperview];
    
//    if (selectPick) {
//        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
//    }
}
-(void)RightAction:(UIButton *)sender{
    sender.selected =! sender.selected;
    
    if (sender.selected) {
        if (!selectPick) {
            UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
            [backBtn addTarget:self action:@selector(RemoveVIew:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backBtn];
            selectAreaPick =[[QJSelectArea alloc]initWithFrame:CGRectMake(0, ConentViewHeight, ConentViewWidth, 250)];
            
            [self.view addSubview:selectAreaPick];
            
            __block  QJSelectArea *BlockselectAreaPick = selectAreaPick;
            __block  UITableView * WeakTv = _tv;
            
            selectAreaPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString, NSString *prvId, NSString *cityId, NSString *AreaId) {
                [backBtn removeFromSuperview];
                
                if (IsCertain) {
                    NSLog(@"区域 %@",dateString);
                    NSArray * CityNameArray =[dateString componentsSeparatedByString:@" "];
                   CityName  = CityNameArray[1];
                     AreaStr = dateString;
                       areaId =AreaId;
                    
                  [userdefautlt setObject:CityName  forKey:@"cityName"];
                  [ userdefautlt  setObject:areaId  forKey:@"AreaId"];
                    [userdefautlt synchronize];
                    [rightBtn setTitle:CityName forState:UIControlStateNormal];

                    numbers = 0 ;
                    [listArr removeAllObjects];
                    [DataArray removeAllObjects];
                    [self makeAppLawyerFinds];
                   // [_tv reloadData];
                    
                }else{
                    
                    
                }
                [UIView animateWithDuration:0.5 animations:^{
                    BlockselectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
                } completion:^(BOOL finished) {
                    
                    [BlockselectAreaPick removeFromSuperview];
                }];
            };
            
            [UIView animateWithDuration:0.5 animations:^{
                selectAreaPick.frame = CGRectMake(0, ConentViewHeight - 250 - 49, ConentViewWidth, 250);
            }];
            
        }
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            selectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
        }];
    }
    
}


-(void)makeTV{
   // DataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];

    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0,45, ConentViewWidth , ConentViewHeight - 45 - 49) style:UITableViewStyleGrouped];

    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tv.delegate= self;
    _tv.dataSource = self;
    
    _tv.estimatedRowHeight = 0;
    _tv.estimatedSectionHeaderHeight = 0;
    _tv.estimatedSectionFooterHeight = 0;
    _tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        numbers = 0;
        [self makeAppLawyerFinds];
    }];
    
    _tv.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self makeAppLawyerFinds];
    }];

    
    
    [self.view addSubview:_tv];

}
#pragma mark 类别列表
- (void)makeLeiBieList{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    lawyerfindsCate
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"类别列表%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            _data1 = [NSMutableArray array];
            NSDictionary *ddic  =@{@"cat_id":@"0",@"cat_name":@"全部"};
            [_data1 addObject:ddic];
            [_data1 addObjectsFromArray:data[@"data"][@"cate"]];
            _data2 = [NSMutableArray array];
            
            [_data2 addObjectsFromArray:@[@{@"id":@"0",@"level_name":@"全部星级"},@{@"id":@"1",@"level_name":@"一级星级"},@{@"id":@"2",@"level_name":@"二级星级"},@{@"id":@"3",@"level_name":@"三级星级"},@{@"id":@"4",@"level_name":@"四级星级"},@{@"id":@"5",@"level_name":@"五级星级"},]];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        
        
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"类别列表%@",error);
    }];

}
#pragma mark 条件查找

- (void)makeAppLawyerFinds{
    
    numbers ++ ;
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Lawyerfinds
    
    NSDictionary * valudic;
    if ([Utile stringIsNil:lonStr]||[Utile stringIsNil:latStr]) {
        valudic  = @{@"lng":@"120.299",@"lat":@"31.568",@"tid":tid,@"lid":lid,@"area_id":areaId,@"p":[NSString stringWithFormat:@"%d",numbers]};
    }else{
        valudic  = @{@"lng":lonStr,@"lat":latStr,@"tid":tid,@"lid":lid,@"area_id":areaId,@"p":[NSString stringWithFormat:@"%d",numbers]};
    }
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"条件查找%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSArray *arrays = [NSArray arrayWithArray:data[@"data"][@"lawyerList"]];
            if (arrays.count > 0) {
                if (numbers == 1) {
                    [listArr removeAllObjects];
                    [DataArray removeAllObjects];
                    [listArr addObjectsFromArray:arrays];
                    for (NSDictionary *dica in arrays) {
                        WYFindViewModel *models = [WYFindViewModel yy_modelWithDictionary:dica];
                        [DataArray addObject:models];
                    }
                }else{
                    [listArr addObjectsFromArray:arrays];
                    for (NSDictionary *dica in arrays) {
                        WYFindViewModel *models = [WYFindViewModel yy_modelWithDictionary:dica];
                        [DataArray addObject:models];
                    }

                }
            }else{
                if (listArr.count == 0) {
                }else{
                    [self showHint:@"暂无更多数据！"];
                }
                numbers -- ;
            }
            
            
            
        }else{
            
            numbers--;
            [self showHint:@"暂无数据！"];
            
        }
        [_tv reloadData];
        [_tv.mj_header endRefreshing];
        [_tv.mj_footer endRefreshing];
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
        numbers -- ;
        [_tv.mj_header endRefreshing];
        [_tv.mj_footer endRefreshing];
        
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"条件查找%@",error);
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return 1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (section == DataArray.count - 1) {
        return 0.01;
    }else{
        return 10;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    WYFindTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"WYFindTableViewCell" owner:self options:nil]lastObject];
    }
    cell.model = DataArray[indexPath.section];
    cell.distanceLab.text = [NSString stringWithFormat:@"%@km",listArr[indexPath.section][@"range"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 132;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    QJlawyerDetailsViewController * lvc= [[QJlawyerDetailsViewController alloc]init];
    lvc.lawyerID = [NSString stringWithFormat:@"%@",listArr[indexPath.section][@"id"]];
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];
    
    NSLog(@"indexPath.row  = %ld",(long)indexPath.row);

}
-(NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{

    if (column==0) {
        
        return _data1.count;
     } else if (column==1){
         return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}
-(BOOL)haveRightTableViewInColumn:(NSInteger)column{

    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
 
    
    return 1;
}
-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
  
    if (column == 0) {
        return _currentData1Index;
    }else if (column == 1){
        return  _currentData2Index;
    }
    return  0;
    
 }
-(void)maketopItem{
    
    
    //_data1 = [NSMutableArray arrayWithObjects:@"业务1wew",@"业务2",@"业务3", nil];
    //_data2 = [NSMutableArray arrayWithObjects:@"律师等级1",@"律师等级2",@"律师等级3",@"律师等级4",nil];
    _data3 = [NSMutableArray arrayWithObjects:@"1km", @"5km", @"10km", nil];
    
    menu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, 0) andHeight:45];
    menu.indicatorColor = [UIColor   grayColor];
    menu.separatorColor = [UIColor clearColor];
    menu.textColor = [UIColor lightGrayColor];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
}

-(void)makeSegment{
    
    NSArray * SgArray =[[NSArray alloc] initWithObjects:@"条件查找",@"地图查找",nil];
    sg =[[UISegmentedControl alloc]initWithItems:SgArray];

    sg.frame = CGRectMake(0, 7, 200, 30);
    sg.clipsToBounds  = YES;
    sg.selectedSegmentIndex = 0;
    sg.tintColor =MAINCOLOR;
    [sg addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                             NSForegroundColorAttributeName: [UIColor colorWithRed:90/255.0 green:181/255.0 blue:233/255.0 alpha:1]};
    [sg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]};
    [sg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    UIView * topVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    [topVIew addSubview:sg];
    self.navigationItem.titleView   = topVIew;

}
-(void)sgAction:(UISegmentedControl *)sender{

    NSLog(@"first");
    if (sender.selectedSegmentIndex == 0) {
        
    }else{
        sg.selectedSegmentIndex = 0;

        QJMapSearchViewController * mvc =[[QJMapSearchViewController alloc]init];
        [self.navigationController pushViewController:mvc animated:NO];

    }

}

-(NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    return 2;
}
 -(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{

     switch (column) {
         case 0:
             return @"业务类型" ;
             break;
             //        case 1: return _data2[0];
         case 1:
             return @"律师星级";
             break;
         case 2:
             return @"离我最近";
             break;
         default:
             return nil;
             break;
     }

}
-(NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{

    switch (indexPath.column) {
        case 0: return _data1[indexPath.row][@"cat_name"] ;
            break;
            //        case 1: return _data2[0];
        case 1:return _data2[indexPath.row][@"level_name"];
            break;
        case 2: return _data3[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}
-(void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{

    switch (indexPath.column) {
        case 0:
            NSLog(@" %@",_data1[indexPath.row][@"cat_id"] );
            _currentData1Index = indexPath.row;
           tid  = [NSString stringWithFormat:@"%@",_data1[indexPath.row][@"cat_id"]];
            numbers = 0 ;
            [listArr removeAllObjects];
            [DataArray removeAllObjects];
            [self makeAppLawyerFinds];
            
            break;
            //        case 1: return _data2[0];
        case 1:
            NSLog(@" %@",_data2[indexPath.row][@"id"] );
          lid   = [NSString stringWithFormat:@"%@",_data2[indexPath.row][@"id"]];
            numbers = 0 ;
            _currentData2Index = indexPath.row;
            [listArr removeAllObjects];
            [DataArray removeAllObjects];
            [self makeAppLawyerFinds];
            break;
        case 2:
            NSLog(@" %@",_data3[indexPath.row] );
            //rid = [NSString stringWithFormat:@"%@",_data1[indexPath.row]];
            break;
        default:
             break;
    }
    
}
#pragma mark  tableViewdelegate


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
