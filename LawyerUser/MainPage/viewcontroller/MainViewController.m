//
//  MainViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "MainViewController.h"
#import "UIImageView+WebCache.h"
#import "xsqbanner.h"
#import "UIViewAdditions.h"
#import "QJMainPageTopView.h"
#import "QJMainPageMiddleView.h"
#import "QJMainPageGoodVIew.h"

#import "QJFindingCell.h"
#import "QJCaseDelegateViewController.h"

#import "QJOneTouchcallingVC.h"
#import "QJAppointment.h"
#import "QJConsultationVc.h"
#import "QJSendingLetters.h"
#import "QJLawyerlettre.h"
#import "QJContactsVC.h"


#import "QJMainBannerModel.h"
#import "QJLawyer.h"

#import "QJlawyerDetailsViewController.h"
#import "WYLunBoViewController.h"

#import "WYTuiJianView.h"
#import "WYPingFenViewController.h"
#import "SGAdvertScrollView.h"
@interface MainViewController ()<SGAdvertScrollViewDelegate>{
    xsqbanner *  BannerView ;
    QJMainPageTopView * TopView;
    QJMainPageMiddleView  * middleView;
    QJMainPageGoodVIew * GoodView;
    WYTuiJianView *tuijianView;
    
    NSMutableArray * bannerArray;
    NSMutableArray *listArr;
    NSString *phoneString;
    CGFloat TuiHeight;
    BOOL isbool;
    
    QJConsultationVc * QConsultationVC;
    QJCaseDelegateViewController * QCaseDelegateVC;
    QJLawyerlettre * lAwyerTtre;
    QJContactsVC * QcontactsVC;
    QJSendingLetters * qSenderVC;
 
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DataArray =[[NSMutableArray alloc]init];
    listArr = [NSMutableArray array];

    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    isbool = YES;
    if (isbool) {
        TuiHeight = 44;
    }else{
        TuiHeight = 0;
        tuijianView.scrollTitle.hidden = YES;
    }
    
    [self makeBackViewScrollView];

    [self getBannerData];
    [self makeJiFenData];
    [self makeData];
    [self makePhoneTel];

    
//    self.title=@"汇融法";
    // Do any additional setup after loading the view.
}

-(void)TopAction{
    NSLog(@"点击了");

}
#pragma mark 客服热线
- (void)makePhoneTel{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UsergetConfig
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"客服热线%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            phoneString = [NSString stringWithFormat:@"%@",data[@"data"]];
            [[NSUserDefaults standardUserDefaults] setObject:phoneString forKey:@"KeFuPhone"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"登录失败，请稍后重试！"];
        NSLog(@"客服热线%@",error);
    }];

}
-(void)makeData{

    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJMainPageData
    
    NSDictionary * valudic;
    if ([Utile stringIsNil:lonStr]||[Utile stringIsNil:latStr]) {
        valudic  = @{@"lng":@"120.299",@"lat":@"31.568"};
    }else{
        valudic  = @{@"lng":lonStr,@"lat":latStr};
    }
    
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"ssssss%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [listArr addObjectsFromArray:data[@"data"]];
            for (NSDictionary * dic in data[@"data"]) {
                QJLawyer * model =[QJLawyer yy_modelWithDictionary:dic];
                 [DataArray addObject:model];
                
            }
            [self ReBackScrollViewHeight ];

            [TV reloadData];
            
        }else{
            
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"sss%@",error);
    }];


}
#pragma mark 积分公告
- (void)makeJiFenData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Indexjf_notice
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"积分公告%@",data);
        NSString *status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if ([status isEqualToString:@"0"]) {
            NSArray *titArr = [NSArray arrayWithArray:data[@"data"]];
            if (titArr.count == 0) {
                isbool = NO;
            }else{
                isbool = YES;
                NSMutableArray *arrayOne = [NSMutableArray array];
                NSMutableArray *arrayTwo = [NSMutableArray array];
                for (NSDictionary *dices in titArr) {
                    [arrayOne addObject:[dices objectForKey:@"name"]];
                    [arrayTwo addObject:[dices objectForKey:@"jf"]];
                    
                }
                
                
                tuijianView.scrollTitle.titles = arrayOne;
                tuijianView.scrollTitle.bottomTitles = arrayTwo;
            }
             ;
            
        }else{
            isbool = NO;
             [self hideHud];
        }
        
        [TV reloadData];
    } failure:^(NSError *error) {
        NSLog(@"积分公告%@",error);
    }];
}
-(void)getBannerData{
    bannerArray =[[NSMutableArray alloc]init];
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJMainBanner
       [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
          
            for (NSDictionary * dic in data[@"data"]) {
                QJMainBannerModel * model =[QJMainBannerModel  yy_modelWithDictionary:dic ];
                 [bannerArray addObject:model];
            }
            [self makeBannerView];
            // bananer  轮播图
        }else{
        }
         [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
}
-(void)makeBackViewScrollView{
    BackScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, - StatusBarHeight, ConentViewWidth, ConentViewHeight - TabBarHeight + NavStatusBarHeight + StatusBarHeight )];
   
 
    BackScrollView.backgroundColor =MainBackColor;
    BackScrollView.contentSize = CGSizeMake(ConentViewWidth, ConentViewHeight *2);
    BackScrollView.alwaysBounceVertical = YES;
    BackScrollView.showsVerticalScrollIndicator = NO;
    BackScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:BackScrollView];
    [self maketopView];
    [self makeMiddleView];
    if (isbool) {
        [self makeFingFen];
    }else{
        [self makeFingFen];
    }
    
    [self makeGoodView];
    [self makeTV];
}
-(void)makeTV{
    
    TV  =[[UITableView alloc]initWithFrame:CGRectMake(0, GoodView.bottom+5, ConentViewWidth, DataArray.count  * 133) style:UITableViewStylePlain];
    TV.delegate= self;
    TV.dataSource= self;
    TV.scrollEnabled = NO;
    TV.showsVerticalScrollIndicator = NO;
    TV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self ReBackScrollViewHeight];
    [BackScrollView addSubview:TV];
}
- (void)makeFingFen{
    tuijianView =[[[NSBundle mainBundle]loadNibNamed:@"WYTuijianView" owner:self options:nil]lastObject];
    
    tuijianView.frame = CGRectMake(0,middleView.bottom +5 , ConentViewWidth , TuiHeight);
    
    tuijianView.scrollTitle.advertScrollViewStyle = SGAdvertScrollViewStyleMore;
    
    
    [tuijianView whenTapped:^{
        
        
        WYPingFenViewController * Qvc  =[[WYPingFenViewController alloc]init];
        Qvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Qvc animated:YES];
        
    }];

    [BackScrollView addSubview:tuijianView];
    if (isbool) {
        tuijianView.hidden = NO;
    }else{
        tuijianView.hidden = YES;
    }

}

- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {

    WYPingFenViewController * Qvc  =[[WYPingFenViewController alloc]init];
    Qvc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:Qvc animated:YES];
}
-(void)makeGoodView{

    
    GoodView =[[[NSBundle mainBundle]loadNibNamed:@"QJMainPageGoodVIew" owner:self options:nil]lastObject];

    GoodView.frame = CGRectMake(0,tuijianView.bottom +5 , ConentViewWidth , 37);
    [BackScrollView addSubview:GoodView];

}

#pragma mark  法律服务
-(void)makeMiddleView{

    middleView =[[[NSBundle mainBundle]loadNibNamed:@"QJMainPageMiddleView" owner:self options:nil]lastObject];
    
    middleView.frame  = CGRectMake(0, TopView.bottom+5, ConentViewWidth, 194 *(ConentViewWidth/375));

    
     [middleView.LeftView whenTouchedUp:^{
         NSLog(@"leftView");
        
     }];
    [middleView.FirstView whenTapped:^{
 
        if (!QCaseDelegateVC) {
            QCaseDelegateVC = [[QJCaseDelegateViewController alloc]init];

        }
    QCaseDelegateVC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:QCaseDelegateVC animated:YES];
  
    }];
    
    [middleView.SecondView whenTapped:^{
        NSLog(@"secondeView");
        if (!lAwyerTtre) {
            lAwyerTtre =[[QJLawyerlettre alloc]init];

        }
        lAwyerTtre.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lAwyerTtre animated:YES];
        
    }];
    [middleView.ThirdView whenTouchedUp:^{
        NSLog(@"ThirdView");
        if (!QcontactsVC) {
            QcontactsVC =[[QJContactsVC alloc]init];
        }
        QcontactsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:QcontactsVC animated:YES];

        
    }];
    
    [middleView.LastView whenTouchedUp:^{
        NSLog(@"lastView");
        if (!qSenderVC) {
            qSenderVC =[[QJSendingLetters alloc]initWithNibName:@"QJSendingLetters" bundle:[NSBundle mainBundle]];

        }
        qSenderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qSenderVC animated:YES];

    }];
    
    
    
    [middleView MakeMiddleViewUI];
    [BackScrollView addSubview:middleView];


}
#pragma  mark  法律咨询
-(void)maketopView{
 
    TopView =[[[NSBundle mainBundle]loadNibNamed:@"QJMainPageTopView" owner:self options:nil]lastObject];

    TopView.frame  = CGRectMake(0, BannerView.bottom+5, ConentViewWidth, 212 );

    [TopView.FirstView whenTapped:^{
     
    
        if (!QConsultationVC) {
             QConsultationVC =[[QJConsultationVc alloc]initWithNibName:@"QJConsultationVc" bundle:[NSBundle mainBundle]];
        }
      
        QConsultationVC.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:QConsultationVC animated:YES];

    }];
    [TopView.SecondVeiw whenTapped:^{
        [self makeAddAction];
//         QJOneTouchcallingVC * pvc =[[QJOneTouchcallingVC alloc]init];
//        pvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:pvc  animated:YES];
   
    }];
    [TopView.CenterView whenTapped:^{
        [self makeAddAction];
//        QJOneTouchcallingVC * pvc =[[QJOneTouchcallingVC alloc]init];
//        pvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:pvc  animated:YES];
 
    }];
    [TopView.ThirdView whenTouchedUp:^{
        
        self.navigationController.tabBarController.selectedIndex = 1;
  
    }];
    [TopView.FourView whenTouchedUp:^{
        
         QJAppointment * pvc =[[QJAppointment alloc]init];
        pvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pvc  animated:YES];

  
    }];
    
   
    [BackScrollView addSubview:TopView];

    
}
- (void)makeAddAction{
    NSString *url = [NSString stringWithFormat:@"联系客服 %@\n周一至周五 9：00-17：00\n是否拨打客服？",phoneString];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:url preferredStyle:UIAlertControllerStyleAlert];
    

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self makePhone];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 拨打电话
- (void)makePhone{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneString];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
    
    
}
-(void)viewWillAppear:(BOOL)animated{
     [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LOCATIONACTION" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];


}
-(void)makeBannerView{
    
    NSMutableArray * bannneImageArray  =[[NSMutableArray alloc]init];
    for (QJMainBannerModel * banmodel in bannerArray) {
        [bannneImageArray addObject:[NSString stringWithFormat:@"%@%@",ImageUrl,banmodel.ad_code]];
    }
 
    BannerView = [xsqbanner direcWithtFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewWidth *0.618) ImageNameArr:bannneImageArray AndImageClickBlock:^(NSInteger index) {
        NSLog(@"sddds");
        
//
//        WYLunBoViewController * lvc= [[WYLunBoViewController alloc]init];
//        QJMainBannerModel *models = bannerArray[index];
//        lvc.lunboUrl = [NSString stringWithFormat:@"%@",models.ad_url];
//        lvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:lvc animated:YES];
//
   
   }];
    
    [self ReBackScrollViewHeight ];
    [BackScrollView addSubview:BannerView];

    

}


#pragma mark       -------------UItabelViewdelegate------------


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJFindingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJFindingCell" owner:self options:nil]lastObject];
    }
    
    cell.Distance.text = [NSString stringWithFormat:@"%@km",listArr[indexPath.section][@"range"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = DataArray[indexPath.section];
    return cell;
}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 133;

}
//- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == DataArray.count - 1) {
//        return 0.01;
//    }else{
//        return 10;
//    }
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}

#pragma  mark  ---------------------计算backView的内容高度
-(void)ReBackScrollViewHeight{
  
    TopView.frame  = CGRectMake(0, BannerView.bottom+5, ConentViewWidth, 212 );

    middleView.frame  = CGRectMake(0, TopView.bottom+5, ConentViewWidth, 194 *(ConentViewWidth/375));
    
    
    tuijianView.frame = CGRectMake(0,middleView.bottom +5 , ConentViewWidth , TuiHeight);
    
    GoodView.frame = CGRectMake(0,tuijianView.bottom +5 , ConentViewWidth , 37);
   
    TV.frame  = CGRectMake(0, GoodView.bottom+5, ConentViewWidth, DataArray.count  * 133) ;

    CGFloat heigt  = GoodView.bottom + 5 +  133 * DataArray.count;
    if (heigt  > BackScrollView.height) {
        BackScrollView.contentSize = CGSizeMake(ConentViewWidth, heigt);
    }else{
    
    BackScrollView.contentSize = CGSizeMake(ConentViewWidth, BackScrollView.height);

    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QJLawyer *models = DataArray[indexPath.section];
    QJlawyerDetailsViewController *lae  = [[QJlawyerDetailsViewController alloc]init];
    lae.lawyerID = [NSString stringWithFormat:@"%@",models.id];
    lae.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lae animated:NO];
    
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
