//
//  lawMineVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/10.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMineVC.h"
#import "LawMineCollectCell.h"
#import "LawMineTopView.h"
#import "LawNewSettingViewController.h"
#import "LawLogionViewController.h"
#import "LawRemainingViewController.h"

//#import "LawConSultViewController.h"
//#import "LawMeetingViewController.h"
//#import "LawSquarSrviceViewController.h"
#import "LawNewHeZuoViewController.h"

#import "LawHeartViewController.h"
#import "LawPackageViewController.h"
#import "LawCollectViewController.h"
#import "LawPersonInfoViewController.h"

#import "QJAboutAppViewController.h"
#import "LawIWantPublicVC.h"

#import "lawVipCentViewController.h"
#import "lawMineVipView.h"

@interface lawMineVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * CollectitemArray;
    NSMutableArray * CollectitemImageArray;
    
    CGFloat Topheight;// Top View 的高度
    CGFloat CollectSpace; // 左侧的距离
    
    BOOL showHud; //第一次显示加载框 其他都不显示了
    
   NSString * VipType;  // VIP 0 不是 1是   2 未登录
    
}
@property (strong ,nonatomic) UICollectionView * collectionView;
@property (strong ,nonatomic) LawMineTopView * collectionTopView;
@end



@implementation lawMineVC


- (void)viewDidLoad {
    [super viewDidLoad];
    VipType = @"2";
    CollectSpace =  0;
    Topheight = 172;
    showHud = YES;
    CollectitemArray = [[NSMutableArray alloc]initWithArray:@[@[@"咨询",@"电话预约",@"见面预约",@"我的订单"],@[@"收藏",@"我要发布",@"客服中心",@"关于汇融法",@"我要合作"]]];
    
    CollectitemImageArray = [[NSMutableArray alloc]initWithArray:@[@[@"main_consult",@"main_telephone",@"main_order",@"main_service"],@[@"my_collect",@"my_release",@"my_customeservice",@"my_about",@"my_cooperation"]]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    MJWeakSelf
    
    [self addRightButtonWithImage:@"nav_setup" preImg:@"nav_setup" actionBlock:^{
        [weakSelf  Pushsetting];
    }];
    
    [self initCollectionView];
    //    [self addCenterLabelWithTitle:@"个人中心" titleColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     if(IsLogin){
        [self requestData];
    }else{
        
        self.infoModel = [[MyInfoModel alloc]init];
        [self.collectionView reloadData];
        
    }
 }
- (void)requestData {
    
    
    [self showHint:nil  inView:self.view];
 
    //action、value
    NSDictionary *valuedic = @{
                               @"uid":UserId,
                               };
    
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewGetInfor ;
    [dic setValue:base64String forKey:@"value"];
   MJWeakSelf;
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        [self hideHud];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            weakSelf.infoModel = [MyInfoModel mj_objectWithKeyValues:responseObjeck[@"data"]];
           
            self->VipType = weakSelf.infoModel.is_vip?weakSelf.infoModel.is_vip:@"2";
            
            
            [self.collectionView reloadData];
        }else{
            [self showHint:responseObjeck[@"msg"]];
        }        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
       [self hideHud];
        [self showHint:@"你的网络好像不太给力\n请稍后再试" ];
    }];
}

-(void)Pushsetting{
    
    NSLog(@"进入设置");
    if(!IsLogin){
        [self  JumpLoginVIewController];
    }else{
        LawNewSettingViewController  * setting =[[LawNewSettingViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
}

#pragma mark  设置CollectionView的的参数
- (void) initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(0,Topheight);
    //    flowLayout.minimumInteritemSpacing =  5 * (SCREENWIDTH/375);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset=  UIEdgeInsetsMake(0, 20, 0, 20);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CollectSpace, NavStatusBarHeight, SCREENWIDTH - CollectSpace*2, SCREENHEIGHT - TabBarHeight- NavStatusBarHeight) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    
    [self.view addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LawMineCollectCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    //    注册头视图
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header removeAllSubviews];
        MJWeakSelf
        if (indexPath.section == 0) {
            
            self.collectionTopView.infoModel = self.infoModel;
            //     41 编辑 42 余额  43  券 44 爱心 100 未登录点击 登录注册跳转登录页面
            self.collectionTopView.TouchBtnBlock = ^(NSInteger index) {
                if(!IsLogin){
                    [weakSelf  JumpLoginVIewController];
                }else{
                    
                    if(index == 41){
                        
                        LawPersonInfoViewController * lawrevc =  [[LawPersonInfoViewController alloc]init];
                        //                  lawrevc.infoModel  =  weakSelf.infoModel ;
                        
                        [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                    }
                    else if (index ==42) {
                        LawRemainingViewController * lawrevc =  [[LawRemainingViewController alloc]init];
                        [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                    }else if (index ==43){
                        LawPackageViewController * lawrevc =  [[LawPackageViewController alloc]init];
                        [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                        
                    }else if (index ==44){
                        
                        LawHeartViewController * lawrevc =  [[LawHeartViewController alloc]init];
                        [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                    }
                }
                
            };
            [header addSubview:self.collectionTopView];
           
            CGFloat   VipHeight =  0;
            lawMineVipView * vipVIew = [[lawMineVipView alloc]init];
            vipVIew.backgroundColor = [UIColor whiteColor];
// 1  Vip  2 不是  3 未登录
            if ([VipType isEqualToString:@"1"]) {
                 VipHeight  = 52;
                vipVIew.frame = CGRectMake(0, Topheight + 10, SCREENWIDTH, 44);
                vipVIew.timeStr = @"2020-11-11";
                
                [vipVIew whenTouchedUp:^{
                    lawVipCentViewController * vipCenter= [[lawVipCentViewController alloc]init];
                    [self.navigationController pushViewController:vipCenter animated:YES];
                }];
                
            }else{
                VipHeight  = 120;
                
                vipVIew.frame = CGRectMake(12, Topheight + 10, SCREENWIDTH - 24, 112);
                vipVIew.VipType =  VipType;
                [vipVIew whenTouchedUp:^{
                    NSLog(@"LookVipDes");
                }];
            }
            [header addSubview:vipVIew];
            UILabel * titleLb =[[UILabel alloc]initWithFrame:CGRectMake(0, Topheight +  VipHeight+  10, SCREENWIDTH, 45)];
            titleLb.text = @"      服务记录";
            [titleLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            titleLb.textColor = [UIColor colorWithHex:0x333333];
            titleLb.backgroundColor = [UIColor whiteColor];
            [header addSubview:titleLb];
            
        } else if (indexPath.section ==1){
            UILabel * titleLb =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREENWIDTH,  45)];
            titleLb.text = @"      其他";
            titleLb.backgroundColor = [UIColor whiteColor];
            
            [titleLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            
            titleLb.textColor = [UIColor colorWithHex:0x333333];
            [header addSubview:titleLb];
            
        }else{
            
            
        }
        header.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        
        return header;
    }
    
    return nil;
}
-(LawMineTopView *)collectionTopView{
    if (!_collectionTopView) {
        _collectionTopView =[[[NSBundle mainBundle]loadNibNamed:@"LawMineTopView" owner:self options:nil]lastObject];
        _collectionTopView.frame = CGRectMake(0, 0,self.collectionView.width, Topheight);
        _collectionTopView.backgroundColor = [UIColor whiteColor];
        _collectionTopView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
    }
    
    return _collectionTopView;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        CGFloat VipHeight = 0;
        if ([VipType isEqualToString:@"1"]) {
            VipHeight = 52;

        }else{
            VipHeight = 120;
        }
        return CGSizeMake(self.collectionView.width, Topheight + 55 +VipHeight );
    }else {
        return CGSizeMake(self.collectionView.width, 55);
    }
}


#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return CollectitemArray.count;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else{
        return 5;
    }
    
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    LawMineCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (cell == nil) {
        
    }
    cell.CellImage.image = [UIImage imageNamed:CollectitemImageArray[indexPath.section][indexPath.row]];
    cell.CellLabel.text = CollectitemArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        if(!IsLogin){
            [self  JumpLoginVIewController];
            return;
        }
        
        
        if(indexPath.row == 0){
            
            
//            LawConSultViewController * adsListVc = [[LawConSultViewController alloc]init];
//            [self.navigationController pushViewController:adsListVc animated:YES];
        }else if (indexPath.row ==1 || indexPath.row ==2){
            
//            LawMeetingViewController * adsListVc = [[LawMeetingViewController alloc]init];
//            if (indexPath.row==1) {
//                adsListVc.meetTing =@"电话预约";
//            }else{
//                adsListVc.meetTing =@"见面预约";
//            }
//            [self.navigationController pushViewController:adsListVc animated:YES];
//
        }else if (indexPath.row==3){
            
//            LawSquarSrviceViewController * adsListVc = [[LawSquarSrviceViewController alloc]init];
//            adsListVc.ServiceTitle = @"法律服务";
//            [self.navigationController pushViewController:adsListVc animated:YES];
        }
        
        
    }
    else{
        
        if (  indexPath.row == 0) {
            if(!IsLogin){
                [self  JumpLoginVIewController];
                return ;
            }
            
            LawCollectViewController *  collec =[[LawCollectViewController alloc]init];
            [self.navigationController pushViewController:collec animated:YES];
        }else  if (  indexPath.row == 1) {
            if(!IsLogin){
                [self  JumpLoginVIewController];
                return ;
                
            }
            
            LawIWantPublicVC * about= [[LawIWantPublicVC alloc] initWithNibName:@"LawIWantPublicVC" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:about animated:YES];
            
        }
        else  if (  indexPath.row == 2) {
            
            [self Callkefu];
        }else if(indexPath.row == 3){
            QJAboutAppViewController * about= [[QJAboutAppViewController alloc] initWithNibName:@"QJAboutAppViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:about animated:YES];
            
            
        }else if (indexPath.row ==4){
            LawNewHeZuoViewController * hezuo  =[[LawNewHeZuoViewController alloc]init];
            [self.navigationController pushViewController:hezuo animated:YES];
        }
        
    }
    
    
}
#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(75 ,90);
}



#pragma  mark   客服电话
-(void)Callkefu{
    
    UIAlertController * AlertVC =[UIAlertController alertControllerWithTitle:@"联系客服" message:[NSString stringWithFormat:@"\n%@\n(工作时间9:00-17:00)\n",APPPhone] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancal =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }] ;
    [cancal setValue:[UIColor colorWithHex:0x999999] forKey:@"_titleTextColor"];
    UIAlertAction * sure  =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4006400661"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
        
    }];
    [AlertVC addAction:cancal];
    [AlertVC addAction:sure];
    [self presentViewController:AlertVC animated:YES completion:nil];
}
-(void)JumpLoginVIewController{
    
    LawLogionViewController *view = [LawLogionViewController new];
    UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
    [UIApplication sharedApplication].delegate.window.rootViewController = na;
    return ;
    
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
