//
//  QJRechargeViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJRechargeViewController.h"
#import "QJPayOneCell.h"
#import "QJTwoCell.h"


@interface QJRechargeViewController (){

    UIButton * BuyBtn;
    
    NSInteger  PayStyle;// 支付的方式  支付宝 0  ，余额  1
}

@end

@implementation QJRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeUI];
    
    // Do any additional setup after loading the view.
}

-(void)makeUI{
    PayStyle = 0;
// 充值或者套餐支付 0 充值 1 套餐  2 服务支付
    if([self.payType  isEqualToString:@"1"]){
        OneDataArray  =  [[NSArray alloc]initWithObjects:
                          @{@"Title":@"支付类型",@"desc":[NSString stringWithFormat:@"购买套餐:%@(%@元)",self.payName,self.payPrice]}
                          ,@{@"Title":@"支付金额",@"desc": [NSString stringWithFormat:@"￥%@",self.payPrice]}, nil];
        TwoDataArray  =[[NSArray alloc]initWithObjects:
                        @{@"Title":@"微信支付",@"desc":@"亿万用户的选择，更快更安全",@"image":@"wx"},
                        @{@"Title":@"余额支付",@"desc":@"可用余额: 待定 元",@"image":@"zfb"},
                        nil];
        self.title = @"套餐支付";
    }else{
        
    }
    
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth , ConentViewHeight  - 150) style:UITableViewStyleGrouped];
    
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.scrollEnabled = NO;
    _tv.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_tv];
    
    
    BuyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BuyBtn.frame =CGRectMake(20, _tv.bottom + 30, ConentViewWidth  - 40, 55);
    [BuyBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [BuyBtn setBackgroundColor:[UIColor lightGrayColor]];
    [BuyBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [BuyBtn createBordersWithColor:MAINCOLOR withCornerRadius:8 andWidth:1];
    
    [BuyBtn addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:BuyBtn];
    
    
    
    
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return   OneDataArray.count;
    }else{
        return  TwoDataArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 ) {
        return 50;
        
    }else{
        return  60;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        UIView * headereView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 60)];
        headereView.backgroundColor = MainBackColor;
        UIView * baview =[[UIView alloc]initWithFrame:CGRectMake(0, 10,ConentViewWidth, 50)];
        baview.backgroundColor = [UIColor whiteColor];
        [headereView addSubview:baview];
        UILabel * title =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ConentViewWidth - 10 , 50)];
        title.text = @"支付方式";
        title.textColor = TintColor;
        [baview addSubview:title];
        return headereView ;
        
    }else{
        return [[UIView alloc]init];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section ==0 ) {
        return 0.0001;
        
    }else{
        return  60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==  0) {
        QJPayOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"QJPayOneCell" owner:self options:nil]lastObject];
            cell.PayTypeLB.text = [OneDataArray[indexPath.row] objectForKey:@"Title"];
            cell.PayConcentTxetField.text = [OneDataArray[indexPath.row] objectForKey:@"desc"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else{
        
        QJTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"QJTwoCell" owner:self options:nil]lastObject];
        }
        cell.PayTypeLB.text = [TwoDataArray[indexPath.row] objectForKey:@"Title"];
        cell.DesLB.text = [TwoDataArray[indexPath.row] objectForKey:@"desc"];
        cell.Imageviewa.image =[UIImage imageNamed:[TwoDataArray[indexPath.row] objectForKey:@"image"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectBtn.userInteractionEnabled = NO;
        cell.SelectBtn.selected = NO;
        if(indexPath.row == PayStyle){
            cell.SelectBtn.selected = YES;
        }
        return  cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        PayStyle  =    indexPath.row;
        [_tv reloadData];
    }
}

-(void)zhifu{
    
    if (PayStyle == 0 ) {// 支付宝
        [self zhifubaoPay];
    }else if (PayStyle == 1){ // 余额
        
    }else{
        
        
    }
    
}
-(void)zhifubaoPay{
    
    
    
    
    
    
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

- (IBAction)EnSureAction:(UIButton *)sender {
}
@end
