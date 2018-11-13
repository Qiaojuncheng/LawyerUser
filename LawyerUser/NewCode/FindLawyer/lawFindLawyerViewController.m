//
//  lawFindLawyerViewController.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/10.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawFindLawyerViewController.h"
#import "JSDropDownMenu.h"
#import "lawMainPageLawyerCell.h"
#import "lawLawyerModle.h"
#import "LawAddressModel.h"
#import "LawConsultTypeModel.h"
#import "lawSearchLawyerVC.h"
#import "lawLawyerdetailVC.h"
@interface lawFindLawyerViewController ()<UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource>{
    JSDropDownMenu *menu;
    
    NSMutableArray * data1;
    NSMutableArray * data2;
    NSMutableArray * data3;
    
    
    NSString * cate_id;// 案件的id
    NSString *area;// 区域id
    NSString *order ;   // 默认 @""    正序 正序 1
    
    NSInteger page ;
    
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
}



@end

@implementation lawFindLawyerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    order = @"";
    cate_id = @"";
    area = @"";
    page =1 ;
    dataArrray = [[NSMutableArray alloc]init];
    [self addCenterLabelWithTitle:@"查找律师" titleColor:nil];
    
    MJWeakSelf;
    [self addRightButtonWithImage:@"bar_02_select" preImg:@"bar_02_select" actionBlock:^{
 
        lawSearchLawyerVC * VC =[[lawSearchLawyerVC alloc]init];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    
    [self addleftButtonWithTitle:@"全部" actionBlock:^{
        self->order = @"";
        self->cate_id = @"";
        self->area = @"";
        self->page =1 ;
        [self makedata];
        [menu removeFromSuperview];
        [self makemenu];

    }];
    [self makedata];
    [self makemenu];
    [self  makeAddreeData];
    [self addView ];
    // Do any additional setup after loading the view.
}

-(void)makemenu{
    menu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, NavStatusBarHeight) andHeight:46];
    menu.indicatorColor = [UIColor   grayColor];
    menu.separatorColor = [UIColor clearColor];
    menu.textColor = [UIColor lightGrayColor];
    menu.dataSource = self;
    menu.delegate = self;
    menu.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:menu];
    
    menu.SelectArray =[[NSMutableArray alloc]init];
    NSArray * numbe = @[@3,@2,@1];
    for(int i = 0 ;i<3 ;i++){
        
        NSMutableArray * nsmutable =[[NSMutableArray alloc]init];
        NSInteger  haveRightTableView = [numbe[i] intValue];
        for (int j = 0; j< haveRightTableView ; j++) {
            NSInteger number = 0;
            [nsmutable addObject:@(number)];
        }
        
        [menu.SelectArray addObject:nsmutable];
    }
    
    
    
}

-(NSInteger )haveRightTableViewInColumn:(NSInteger)column{
    //    0 一个  1 两个    2 三个
    if (column == 0) {
        return  2;
    }else if(column== 1){
        return 1;
    }
    return 0;
}
-(NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    NSMutableArray * ColumnlectDataArray    =[[NSMutableArray alloc]initWithArray:menu.SelectArray[column]];
    
    if (column == 0) {
        if(leftOrRight == 0){//  0 左侧  1 中间  2 右侧
            return data1.count;
        }else if(leftOrRight == 1){
            LawAddressModel * proModel = data1[[ColumnlectDataArray[0] integerValue]];
            return proModel.child.count;
        }else if(leftOrRight == 2){
            
            LawAddressModel * proModel = data1[[ColumnlectDataArray[0] integerValue]];
            LawAddressModel * cityModel = proModel.child[[ColumnlectDataArray[1] integerValue]];
            
            return cityModel.child.count;
            
        }
        
    }else if(column == 1){
        if(leftOrRight == 0){//  0 左侧  1 中间  2 右侧
            return data2.count;
        }else if(leftOrRight == 1){
            
            LawConsultTypeModel * TypeModel = data2[[ColumnlectDataArray[0] integerValue]];
            
            
            
            return TypeModel.second_child.count;
            
            
        }
    }else if(column == 2){
        return data3.count;
        
    }
    
    return 0;
}
-(NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    return 3;
}
-(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return @"区域选择" ;
            break;
            //        case 1: return _data2[0];
        case 1:
            return @"案件类型";
            break;
        case 2:
            return @"执业年限";
            break;
        default:
            return nil;
            break;
    }
    
}
-(NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    
    NSMutableArray * ColumnlectDataArray    =[[NSMutableArray alloc]initWithArray:menu.SelectArray[indexPath.column]];
    
    
    
    switch (indexPath.column) {
        case 0:
            
            
            if (indexPath.leftOrRight == 0) {
                LawAddressModel * Promodle =   data1[indexPath.row];
                return [NSString stringWithFormat:@"%@",Promodle.name];
            }else if (indexPath.leftOrRight == 1){
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                LawAddressModel * proModel = data1[[leftSelectNumber  integerValue]];
                LawAddressModel * Citymodle =   proModel.child[indexPath.row];
                return [NSString stringWithFormat:@"%@",Citymodle.name]; //_data1[indexPath.row][@"cat_name"] ;
                
            }else{
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                NSNumber * rightSelectNumber =   ColumnlectDataArray[1];
                LawAddressModel * proModel = data1[[leftSelectNumber integerValue] ];
                LawAddressModel * Citymodle =   proModel.child[[rightSelectNumber integerValue]];
                LawAddressModel * Areamodel =   Citymodle.child[indexPath.row];
                
                return [NSString stringWithFormat:@"%@",Areamodel.name]; //
            }
            break;
            //        case 1: return _data2[0];
        case 1:
            if (indexPath.leftOrRight == 0) {
                LawConsultTypeModel * typeOne = data2[indexPath.row];
                return typeOne.name;
                
            }else{
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                LawConsultTypeModel * typeOne = data2[[leftSelectNumber integerValue]];
                LawConsultTypeModel * typtwo = typeOne.second_child[indexPath.row];
                
                return typtwo.name;
                
            }
            break;
        case 2:
            return  data3[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

//-(NSInteger)currentLeftSelectedRow:(NSInteger)column {
//
//}
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column {
    if (column ==0) {
        return  .33333f;
        
    }else if(column ==1){
        return  0.5;
    }else{
        return  1;
        
    }
}

-(void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    
    NSMutableArray * ColumnlectDataArray =menu.SelectArray[indexPath.column];
    switch (indexPath.column) {
        case 0:
            if(indexPath.leftOrRight ==2){
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                NSNumber * rightSelectNumber =   ColumnlectDataArray[1];
                LawAddressModel * proModel = data1[[leftSelectNumber integerValue] ];
                LawAddressModel * Citymodle =   proModel.child[[rightSelectNumber integerValue]];
                LawAddressModel * Areamodel =   Citymodle.child[indexPath.row];
                area = Areamodel.id;
                NSLog(@"first %@ = id= %@",Areamodel.name ,Areamodel.id);
                page = 1;
                [self makedata];
                
            }
            break;
        case 1:
            if (indexPath.leftOrRight == 1) {
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                LawConsultTypeModel * typeOne = data2[[leftSelectNumber integerValue]];
                LawConsultTypeModel * typtwo = typeOne.second_child[indexPath.row];
                cate_id = typtwo.id;
                NSLog(@" third = %@ ，name = %@  ",typtwo.id,typtwo.name);
                page = 1;
                [self makedata];
                
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                order = @"";
            }else if(indexPath.row == 1) {
                order = @"0-3";
            }else if (indexPath.row == 2) {
                order = @"3-10";
            }
            else if (indexPath.row == 3) {
                order = @"10";
            }
            page = 1;
            [self makedata];
            
            
            break;
        default:
            break;
    }
    
}

-(void)makedata{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    LawMaingetLawyerList
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:[NSString stringWithFormat:@"%ld",page ] forKey:@"p" ];
    [valueDic setObject:order forKey:@"year" ];
    [valueDic setObject:cate_id  forKey:@"cate" ];
    [valueDic setObject:area forKey:@"area" ];
    
    
    
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
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 44 + 10, SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight -44 - 30) style:UITableViewStylePlain];
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



-(void)makeAddreeData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AreaData" ofType:@"plist"];
    NSArray *   plistData = [NSMutableArray arrayWithContentsOfFile:path];
    data1 =[[NSMutableArray alloc]init];
    for (NSDictionary * proDic in plistData) {
        //省
        LawAddressModel * proModel =[LawAddressModel yy_modelWithJSON:proDic];
        
        [data1 addObject:proModel];
        
    }
    
    data3 =[[NSMutableArray alloc]initWithArray:@[@"全部",@"0-3年",@"3-10年",@"10年以上"]];
    
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultGetType
    
    
    //    获取分类
    
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [self hideHud];
        data2 =[[NSMutableArray alloc]init];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            for (NSDictionary * proDic in responseObjeck[@"data"]) {
                
                LawConsultTypeModel * TypeModel =[LawConsultTypeModel yy_modelWithJSON:proDic];
                [data2 addObject:TypeModel];
                
            }
            
        }else{
        }
    } failure:^(NSError *error) {
        [self hideHud];
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
