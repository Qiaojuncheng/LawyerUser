//
//  lawVipZoneVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/4.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipZoneVC.h"
#import "lawVipConcentModel.h"
#import "lawVipZoneTopView.h"
#import "lawVipZoneMiddleCell.h"
#import "lawCompanyCell.h"
@interface lawVipZoneVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;// vip 内容的数组
    NSMutableArray * CompanyArray ;
    UITableView * _tableView;
    NSString * wexin;
    NSString * QQStr ;
 }
@property (strong , nonatomic) lawVipZoneTopView *VipTopView;
@end

@implementation lawVipZoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCenterLabelWithTitle:@"企业VIP专区" titleColor:nil];
    dataArrray =[[NSMutableArray alloc]init];
    CompanyArray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
    
    [self addView];
    [self makeVipInfo];
    [self makeCompanyInfo];
    // Do any additional setup after loading the view.
}
-(lawVipZoneTopView *)VipTopView{
    if (!_VipTopView) {
        _VipTopView =[[[NSBundle mainBundle]loadNibNamed:@"lawVipZoneTopView" owner:self options:nil]lastObject];
        _VipTopView.changHeightBlock = ^(CGFloat height) {
            self->_VipTopView.height = height;
            [self->_tableView reloadData];
        };
        
        
        [_VipTopView makeSubviews];
    }
    
    return _VipTopView ;
}

-(void)makeVipInfo{
    
         [self showHudInView:self.view hint:nil];
      NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
         NewIndex
      NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    [valuedic  setObject:UserId forKey:@"mid"];
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
        
        [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
            [self hideHud];
            // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
                     [dataArrray removeAllObjects];
                 for (NSDictionary  * dicc in responseObjeck[@"data"]) {
                    
                    lawVipConcentModel * model = [lawVipConcentModel yy_modelWithJSON:dicc];
                    [dataArrray addObject:model];
                     
                    
                }
                self.VipTopView.DataArray = dataArrray;
                [_tableView reloadData];
            }
           
            
        } failure:^(NSError *error) {
            [self hideHud];
            
        }];
        
 
}
-(void)makeCompanyInfo{
    
    [self showHudInView:self.view hint:nil];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewLawEnterprise
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    [dic setValue:base64String forKey:@"value"];
    
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        [self hideHud];
        // 处理数据
        if ([responseObjeck[@"status"] integerValue] == 0) {
            self->wexin = [NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"contact"][@"weixin"]];
            self->QQStr =[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"contact"][@"qq"]];
            [self makeFootView];

            [CompanyArray removeAllObjects];
            for (NSDictionary  * dicc in responseObjeck[@"data"][@"enterprise"]) {
                lawCompanyModel * model = [lawCompanyModel yy_modelWithJSON:dicc];
                [CompanyArray addObject:model];
             }
             [_tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        [self hideHud];
        
    }];
    
    
}
-(void)makeFootView{
    
    UIView *Footview = [[UIView alloc] init];
    Footview.frame = CGRectMake(0,SCREENHEIGHT - 40,SCREENWIDTH ,40);
    Footview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Footview];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,0,89,40);
    label.text = @"企业合作请联系：";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [Footview addSubview:label];
    
    UIImageView *WXimageView = [[UIImageView alloc] init];
    WXimageView.frame = CGRectMake(101.5,9,23,23);
   WXimageView.image = [UIImage imageNamed:@"contact_wechat"];
    [Footview addSubview:WXimageView];
    
    UILabel *WXlabel = [[UILabel alloc] init];
    WXlabel.frame = CGRectMake(130.5,0,108.5,40);
    WXlabel.text =[NSString stringWithFormat:@"微信：%@",wexin];
    WXlabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
    WXlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [Footview addSubview:WXlabel];
    
    
    UIImageView *QQimageView = [[UIImageView alloc] init];
    QQimageView.frame = CGRectMake(WXlabel.right+12,9,23,23);
    QQimageView.image = [UIImage imageNamed:@"contact_qq"];
    [Footview addSubview:QQimageView];
    
    UILabel *QQlabel = [[UILabel alloc] init];
    QQlabel.frame = CGRectMake(QQimageView.right+ 6,0,108.5,40);
    QQlabel.text =[NSString stringWithFormat:@"QQ：%@",QQStr];
    QQlabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
    QQlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [Footview addSubview:QQlabel];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 50;
    
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}



-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 10 , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  - 10 -40) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    _tableView.tableHeaderView = self.VipTopView;

    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        return CompanyArray.count;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
         lawVipZoneMiddleCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"lawVipZoneMiddleCell" owner:self options:nil]lastObject];
        }
//        cell.model= dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else{
        lawCompanyCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"lawCompanyCell" owner:self options:nil]lastObject];
        }
            cell.model= CompanyArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;

        
    }
    return  [[UITableViewCell alloc]init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  [[UIView alloc]init];
    }else{
        UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
                UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(16.5,0,100,50);
        label.text = @"合作企业";
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        
        [headerView addSubview:label];
        return  headerView;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.001;
    }else{
        return  50;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 245;
    }else{
        return 55;
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
