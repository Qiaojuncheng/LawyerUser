//
//  LawMainPageViewController.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/10.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "LawMainPageViewController.h"
#import "LawMainTopView.h"
#import "LawNewHeaterModel.h"
#import "xsqbanner.h"
#import "lawMainMiddleView.h"
#import "lawMainPageLawyerCell.h"
#import "lawLawyerModle.h"
#import "lawLawyerdetailVC.h"
#import "lawSearchLawyerVC.h"
#import "lawPublicLegalSevice.h"
#import "LawMianPageMessageCenter.h"
#import "lawVipCentViewController.h"
#import "lawNearLawyerVC.h"
#import "lawVipZoneVC.h"
@interface LawMainPageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    //     右上角的红点
    UIView * tipView;
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger  page ;

    xsqbanner * bannerView ;
    
    NSMutableArray * BannerImageArraay ;
    NSMutableArray *HearDataArray ;// 心意数据


}
@property (strong , nonatomic) LawMainTopView * topItemView;
@property (strong , nonatomic) UIView * TopHeaderView ;

@end

@implementation LawMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HearDataArray =[[NSMutableArray alloc]init];
    dataArrray =[[NSMutableArray alloc]init];
    [self getData];
    BannerImageArraay =[[NSMutableArray alloc]init];
    page =1 ;
    [self addCentersearchView];
    [self addLeftButtonWithImage:@"nav_phone_blue" preTitle:@"客服"];
    [self addRightButtonWithImage:@"nav_news_blue"];

    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushAction:) name:@"PushMessage" object:nil];
    [self addView];
    [self  getBannerData];
    [self  getHeat];
}
-(void)PushAction:(NSNotification *)nofi{
    NSLog(@"%@ === %@ === %@", nofi.object, nofi.userInfo, nofi.name);
    tipView.hidden = NO;
 
}
-(void)addCentersearchView{
    MJWeakSelf
    UIImageView * TopCenterImage =[[UIImageView alloc]initWithFrame:CGRectMake(85, StatusBarHeight + 8, SCREENWIDTH - 140, 28)];
    TopCenterImage.image =[UIImage imageNamed:@"search"];
    TopCenterImage.userInteractionEnabled = YES ;
    [TopCenterImage  whenTapped:^{
        lawSearchLawyerVC * VC =[[lawSearchLawyerVC alloc]init];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    
    [self.naviBarView  addSubview:TopCenterImage];

}

// 获取数据
-(void)getData{
//
        NSDictionary * dic  =[[NSMutableDictionary alloc]init];
        LawMaingetTuiLawyer
    
        NSDictionary * valudic  = @{@"p":[NSString stringWithFormat:@"%ld",page]};
        NSString * baseStr = [NSString getBase64StringWithArray:valudic];
        [dic setValue:baseStr forKey:@"value"];
        if(page==1){
            [self showHudInView:self.view hint:nil];
         }

        [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
            NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
            if ([str isEqualToString:@"0"]) {
                if (page == 1) {
                    [dataArrray removeAllObjects];
                }
                for (NSDictionary * dicc in data[@"data"]) {
                    lawLawyerModle * model = [lawLawyerModle yy_modelWithJSON:dicc];
                    [dataArrray addObject:model];
                }
                [_tableView reloadData];
            }
            [self hideHud];
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
            [self hideHud];
            NSLog(@"%@",error);
        }];

 
}
#pragma  mark 添加 tableview
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - TabBarHeight) style:UITableViewStylePlain];
    _tableView.tableHeaderView = self.TopHeaderView;
    _tableView.separatorColor = [UIColor colorWithHex:0x999999];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++ ;
        [self getData ];
    }];
    _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page =1 ;
        [self getData ];
    }];
    
    [self.view addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArrray.count;
        
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 108 ;
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    lawLawyerdetailVC * detail =[[lawLawyerdetailVC alloc]init];
    lawLawyerModle * model = dataArrray[indexPath.row];
    detail.lawyerid = model.id;
    [self.navigationController pushViewController:detail animated:YES];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
        lawMainPageLawyerCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"Lawyercell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"lawMainPageLawyerCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=  dataArrray[indexPath.row];
//        if(!IsLogin){
//            cell.answBtn.hidden = YES ;
//        }
    return  cell;
//
    
    
}

-(UIView *)TopHeaderView{
    if (!_TopHeaderView) {
        
        _TopHeaderView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 660)];
        [self makeTopSubView];
      

    }
    return  _TopHeaderView;
}
-(void)makeTopSubView{
    
#pragma mark    banner图
    
    bannerView = [xsqbanner direcWithtFrame:CGRectMake(15, 10, SCREENWIDTH - 30, 160) ImageNameArr:@[@"1c514a19cd4eb919ad3e81ab66151a375b8fd6e151d09.png"] AndImageClickBlock:^(NSInteger index) {
        
    }];
    
     [Utile makeCorner:10 view:bannerView];
    [_TopHeaderView addSubview:bannerView];
 
#pragma mark    附近律师和会员专区
    
    for (int i  = 0 ; i < 2; i++) {
        lawMainMiddleView * middleView  =[[ lawMainMiddleView alloc]initWithFrame:CGRectMake(((SCREENWIDTH - 45)/2  +15 )* i + 15 , bannerView.bottom + 20, (SCREENWIDTH - 45) /2, 140)];
        middleView.backgroundColor =[ UIColor whiteColor];
        [middleView createCornerRadiusShadowWithCornerRadius:6 offset:CGSizeMake(1, 1) opacity:.16 radius:15 Color:[UIColor colorWithHex:0x265995]];
  
        [_TopHeaderView addSubview:middleView];
        
        
        if (i == 0) {
            middleView.ImageStr = @"icon_main01";
            middleView.TitleStr = @"附近律师";
            middleView.DesStr  = @"最快30分钟到您身边";
        }else   if (i == 1){
             middleView.BackImageStr = @"bg_main02";
            middleView.ImageStr = @"icon_main02";
            middleView.TitleStr = @"会员专区";
            middleView.DesStr  = @"中小微企业法律服务";
        }
        
        [middleView whenTapped:^{
            if (i == 0) {

                     lawNearLawyerVC * vipCenter= [[lawNearLawyerVC alloc]init];
                [self.navigationController pushViewController:vipCenter animated:YES];            }else{
                if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"is_vip"] isEqualToString:@"1"]) {
                         lawVipCentViewController * vipCenter= [[lawVipCentViewController alloc]init];
                        [self.navigationController pushViewController:vipCenter animated:YES];
 
                }else{
                       lawVipZoneVC * vc=[[lawVipZoneVC alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                  }
            }
        }];
        
    }
    
 
    
    _topItemView = [[[NSBundle mainBundle]loadNibNamed:@"LawMainTopView" owner:self options:nil] lastObject];
    _topItemView.frame = CGRectMake(0, bannerView.bottom + 180, SCREENWIDTH, 320);
//    __weak typeof(_topItemView)  weaktopView = _topItemView;
 
    
    NSArray * imageArray = @[@"icon_service01",@"icon_service02",@"icon_service03",@"icon_service04",@"icon_service05",@"icon_service06",@"icon_service07",@"icon_service08"];
    NSArray * TitleArray = @[@"常年顾问服务",@"案件委托",@"发律师函",@"合同审查",@"合同起草",@"民刑监督",@"线下店铺",@"费用计算"];

    [_topItemView makeItemWithTitleArray:TitleArray ImageArray:imageArray];

    [_TopHeaderView addSubview:_topItemView];
//    MJWeakSelf;
#pragma mark    30 @"常年顾问服务",@"案件委托",@"发律师函",@"合同审查",@"合同起草",@"民刑监督",@"线下店铺",@"费用计算"

    _topItemView.ItemselectBlock = ^(NSInteger index) {

                if(index == 30){
                    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"is_vip"] isEqualToString:@"1"]) {
                        lawVipCentViewController * vipCenter= [[lawVipCentViewController alloc]init];
                        [self.navigationController pushViewController:vipCenter animated:YES];
                        
                    }else{
                        lawVipZoneVC * vc=[[lawVipZoneVC alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }else if(index == 31) {
                    lawPublicLegalSevice * Service =[[lawPublicLegalSevice alloc]init];
                    Service.hidesBottomBarWhenPushed = YES ;
                    Service.type = @"1";
                    [self.navigationController pushViewController:Service animated:YES ];
                }else if(index == 32) {
                    lawPublicLegalSevice * Service =[[lawPublicLegalSevice alloc]init];
                    Service.hidesBottomBarWhenPushed = YES ;
                    Service.type = @"2";
                    [self.navigationController pushViewController:Service animated:YES ];
                }else if(index == 33) {
                    lawPublicLegalSevice * Service =[[lawPublicLegalSevice alloc]init];
                    Service.hidesBottomBarWhenPushed = YES ;
                    Service.type = @"3";
                     [self.navigationController pushViewController:Service animated:YES ];
                }else if(index == 34) {
                    lawPublicLegalSevice * Service =[[lawPublicLegalSevice alloc]init];
                    Service.hidesBottomBarWhenPushed = YES ;
                    Service.type = @"4";
                     [self.navigationController pushViewController:Service animated:YES ];
                }else {
                    [self showHint:@"功能正在开发中敬请期待！"];

                }

    };
 
}





#pragma  mark 左右item
- (void)addLeftButtonWithImage:(NSString *)image preTitle:(NSString *)preTitle
{
    UIButton *LeftBtn = [UIButton buttonWithType:0];
    LeftBtn.backgroundColor = [UIColor clearColor];
    [LeftBtn setNormalImage:image];
    [LeftBtn setPressedImage:image];
    [LeftBtn setTitle:preTitle forState:UIControlStateNormal];
    [LeftBtn setTitleColor:[UIColor colorWithHex:0x3181FE]];
    [LeftBtn addClickTarget:self action:@selector(leftBar_Action:)];
    [self.naviBarView addSubview:LeftBtn];
    LeftBtn.sd_layout
    .leftSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(70)
    .heightIs(44);
}
- (void)addRightButtonWithImage:(NSString *)image  {
    
    UIButton *rightButton = [UIButton buttonWithType:0];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setNormalImage:image];
    [rightButton setPressedImage:image];
    [rightButton addClickTarget:self action:@selector(rightBar_Action:)];
    [self.naviBarView addSubview:rightButton];
    rightButton.sd_layout
    .rightSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(44)
    .heightIs(44);
    
    tipView = [[UIView alloc] initWithFrame:CGRectMake(rightButton.width - 15, 10, 8, 8)];
    [Utile makeCorner:tipView.height/2 view:tipView];
    [rightButton addSubview:tipView];
    
}
#pragma mark 轮播数据
-(void)getBannerData{
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    LawMainBanner
    NSDictionary * valudic  = @{};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
   
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self->BannerImageArraay removeAllObjects];
            for (NSDictionary * dic in data[@"data"]) {
                [self->BannerImageArraay addObject:[NSString stringWithFormat:@"%@%@",ImageUrl,dic[@"pic"]]];
            }
            if(BannerImageArraay.count > 0){
                self->bannerView.imageArr =BannerImageArraay;
            }
        }
        [self hideHud];
        
    } failure:^(NSError *error) {
        
        [self hideHud];
        NSLog(@"%@",error);
    }];

    
}

#pragma mark 送心意数据
-(void)getHeat{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewHetermind
    NSDictionary * valudic =[[NSDictionary alloc]init] ;
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        
        if ([str isEqualToString:@"0"]) {
            for (NSDictionary * dicc in data[@"data"]) {
                LawNewHeaterModel * model = [LawNewHeaterModel yy_modelWithJSON:dicc];
                [self->HearDataArray addObject:model];
            }
            
            [self->_topItemView makeDataWithScrollLBArray:self->HearDataArray];
         }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    

    
}

#pragma mark 客服
-(void)leftBar_Action:(UIButton *)sender{
    
    UIAlertController * AlertVC =[UIAlertController alertControllerWithTitle:@"联系客服" message:[NSString stringWithFormat:@"\n%@\n(工作时间9:00-17:00)\n",APPPhone] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancal =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }] ;
    [cancal setValue:[UIColor colorWithHex:0x999999] forKey:@"_titleTextColor"];
    UIAlertAction * sure  =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",APPPhone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
        
    }];
    [AlertVC addAction:cancal];
    [AlertVC addAction:sure];
    [self presentViewController:AlertVC animated:YES completion:nil];
}
#pragma mark 通知
-(void)rightBar_Action:(UIButton * )sender{
    
//      判断登录；
     PostComeinLogionNotific
    
       tipView.hidden = YES ;
 
    NSLog(@"通知");
    LawMianPageMessageCenter* messagecent = [[LawMianPageMessageCenter alloc]init];
    [self.navigationController pushViewController:messagecent animated:YES];
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
