//
//  QJOneTouchcallingVC.m
//  Lawyer
//
//  Created by MYMAc on 2017/7/24.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJOneTouchcallingVC.h"
#import "QJOneTocuhCell.h"
#import "QJSelectItemView.h"

@interface QJOneTouchcallingVC ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView * _TV;
    NSMutableArray * titleArray; // 标题的数组
   
    NSString * oneStr;
    NSString * TwoStr;
    NSString * ThirdStr;
    NSString * fourStr;
    
    
    NSArray * AreaArray; // 区域的数组
    NSArray * SupNeedArray; // 需求的数组
    NSArray * lawyerLanguageArray; // 律师的数组
    NSArray * LawyerLeveArray; // 区域的数组

}

@end

@implementation QJOneTouchcallingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"一键呼叫";
    titleArray =[[NSMutableArray alloc]initWithArray:@[@"执法地域",@"需求分析",@"律师语言",@"律师等级"]];
    [self makeTV];
    //[self makeBackItem];
    
    AreaArray =@[@"中国",@"香港",@"台湾",@"澳门"];
    SupNeedArray =@[@"婚姻家庭",@"房产合同",@"交通事故",@"医疗纠纷"];
    lawyerLanguageArray =@[@"中文",@"英语",@"日语",@"韩语"];
    LawyerLeveArray =@[@"1级",@"2级",@"3级",@"4级",@"5级",@"6级",@"7级",@"8级",@"9级",@"10级",@"11级",@"12级"];
    oneStr = AreaArray [0];
    TwoStr  = SupNeedArray[0];
    ThirdStr  = lawyerLanguageArray [0];
    fourStr =LawyerLeveArray[0];
    
    // Do any additional setup after loading the view.
}
-(void)makeTV{

    _TV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ConentViewWidth ,ConentViewHeight) style:UITableViewStylePlain];

    _TV.delegate=  self;
    _TV.dataSource = self;
    _TV.scrollEnabled = NO;
    _TV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_TV];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QJOneTocuhCell * cel = [tableView dequeueReusableCellWithIdentifier:@"onetouchcell"];
    if (cel == nil) {
    cel =  [[[NSBundle mainBundle]loadNibNamed:@"QJOneTocuhCell" owner:nil options:nil]lastObject];
    }
    cel.CellNameLB.text = titleArray[indexPath.row];
    cel.CellDetailLB.text =@"执法区域";
    if (indexPath.row ==0) {
        cel.CellDetailLB.text = oneStr;
    }else if(indexPath.row == 1){
        cel.CellDetailLB.text = TwoStr;
    }else if(indexPath.row == 2){
        cel.CellDetailLB.text = ThirdStr;
    }else if(indexPath.row == 3){
        cel.CellDetailLB.text = fourStr;
    }
    cel.selectionStyle = UITableViewCellSelectionStyleNone;
      return cel;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 120)];
    footView.backgroundColor =[UIColor colorWithHex:0xE7F3FA];
    UILabel * timeLbae =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, ConentViewWidth , 20)];
    timeLbae.textColor = MAINCOLOR;
    timeLbae.text = @"6-12/分钟";
    [footView addSubview:timeLbae];
    timeLbae.textAlignment = NSTextAlignmentCenter;
    timeLbae.font = [UIFont systemFontOfSize:13];

    UILabel * onelible =[[UILabel alloc]initWithFrame:CGRectMake(0, timeLbae.bottom + 20, ConentViewWidth    , 20)];
    
    onelible.text =@"会员套餐可免费咨询";
    onelible.textColor =[UIColor colorWithHex:0x888888];
    [footView addSubview:onelible];
    onelible.textAlignment = NSTextAlignmentCenter;
    onelible.font = [UIFont systemFontOfSize:13];

    UILabel * Twolible =[[UILabel alloc]initWithFrame:CGRectMake(0, onelible.bottom+10 , ConentViewWidth , 20)];
    
    Twolible.text =@"通常您的问题可以在10-15分钟内解决";
    Twolible.textColor =[UIColor colorWithHex:0x888888];
    Twolible.textAlignment = NSTextAlignmentCenter;
    Twolible.font = [UIFont systemFontOfSize:13];

    [footView addSubview:Twolible];


    return footView ;

}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
    if (indexPath.row ==0) {
        seleView.ViewTitlt= @"执法领域";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:AreaArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
            oneStr = AreaArray[index];
             [_TV reloadData];
        };
    }else if (indexPath.row ==1){
        
        seleView.ViewTitlt= @"需求分析";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:SupNeedArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
             TwoStr = SupNeedArray[index];
             [_TV reloadData];
        };


    }else if (indexPath.row ==2){
        
        seleView.ViewTitlt= @"律师语言";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:lawyerLanguageArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
             ThirdStr = lawyerLanguageArray[index];
             [_TV reloadData];
        };


    }else if (indexPath.row ==3){
        seleView.ViewTitlt= @"律师等级";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:LawyerLeveArray];
        seleView.selectWithIndexBlcik = ^(int index) {
             fourStr = LawyerLeveArray[index];
            [_TV reloadData];
        };

    }
    [self.view addSubview:seleView];
    [seleView showView];
//    [seleView whenTapped:^{
//        [seleView dismissView];
//    }];
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
