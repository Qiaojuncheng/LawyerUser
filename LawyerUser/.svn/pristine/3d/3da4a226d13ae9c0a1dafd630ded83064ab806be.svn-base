//
//  QJVipVc.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/22.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJVipVc.h"
#import "QJVipTopView.h"
#import "QJVipCell.h"
#import "QJVipBottomView.h"
#import "QJPayViewController.h"
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


@interface QJVipVc ()<UITableViewDelegate,UITableViewDataSource,SKPaymentTransactionObserver,SKProductsRequestDelegate>{


    UIScrollView * BackScroll;
    QJVipTopView * topView ;
    UITableView * _TV;
    UIButton * buyBtn;
    QJVipBottomView * bottomView;
    
    NSString * seleTaoCanID;// 选中的套餐id
    
    NSMutableArray *  DataArray;
    
    
    NSInteger  selectIndex; // 选中的cell index
    
    NSString * OrderId  ; // 订单ID
}

@end

@implementation QJVipVc

- (void)viewDidLoad {
    [super viewDidLoad];
    selectIndex = UID_MAX;
    self.title = @"VIP会员";
    [self MaekData];
    DataArray =[[NSMutableArray alloc]init];
    [self makeUI];
    // Do any additional setup after loading the view.
}


-(void)makeUI{
    BackScroll  =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];

    BackScroll.backgroundColor = MainBackColor;
    BackScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:BackScroll];
    
      topView =[[[NSBundle mainBundle]loadNibNamed:@"QJVipTopView" owner:self options:nil]lastObject];
    topView.frame = CGRectMake(0, 0, ConentViewWidth, 240);
    topView.BuyLBName.text = @"";
    [BackScroll addSubview:topView];

    
    _TV  =[[UITableView alloc]initWithFrame:CGRectMake(0, topView.bottom, ConentViewWidth, DataArray.count * 30) style:UITableViewStylePlain];
    _TV.delegate= self;
    _TV.dataSource=  self;
    _TV.backgroundColor=  MainBackColor;
    _TV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TV.scrollEnabled = NSNotFound;
    [BackScroll addSubview:_TV];
    
     buyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(20, _TV.bottom+ 20, ConentViewWidth - 40, 40);
    [buyBtn setTitle:@"在线购买" forState:UIControlStateNormal];
    [buyBtn  createBordersWithColor:nil withCornerRadius:4 andWidth:0];

    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:MAINCOLOR];
    [buyBtn addTarget:self action:@selector(BuyBtnActi) forControlEvents:UIControlEventTouchUpInside];
    [BackScroll addSubview:buyBtn];
    bottomView = [[[NSBundle mainBundle]loadNibNamed:@"QJVipBottomView" owner:self options:nil]lastObject];
     bottomView.frame = CGRectMake(0, buyBtn.bottom + 20, ConentViewWidth, 277);
     [BackScroll addSubview:bottomView];
    
    BackScroll.contentSize= CGSizeMake(ConentViewWidth, bottomView.bottom);

    
    
 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJVipCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJVipCell" owner:self options:nil]lastObject];
    }
    
    [cell makeCellWithDic:DataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.SelctBtn.userInteractionEnabled = NO;
 
    if (indexPath.row  == selectIndex) {
        cell.SelctBtn.selected = YES;
    }else{
        cell.SelctBtn.selected = NO;

    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    selectIndex = indexPath.row;
    [_TV reloadData];

}

-(void)BuyBtnActi{
    if (selectIndex  == UID_MAX) {
        
        [self showHint:@"请选择套餐项目"];
        return ;
    }
     NSDictionary * dics = DataArray[selectIndex];
    NSLog(@"maimaimaiam买买ID == %@",dics[@"id"]);
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    VIpOrder
    NSDictionary * valueDic  = @{@"uid":UserId,@"sid":dics[@"id"]};
    
    //    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
         NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            OrderId  =  data[@"data"];
            QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.payType = @"1";
            pavVc.payID= data[@"data"];
            pavVc.payName= dics[@"name"];
            pavVc.payPrice = dics[@"price"];
            
            [self.navigationController pushViewController:pavVc animated:YES];
//        进入支付界面；
         }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    

    
}
-(void)MaekData{


    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    VIPTAOCAN
    NSDictionary * valueDic  = @{@"user_id":UserId};
    //    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            DataArray = [[NSMutableArray alloc]initWithArray:data[@"data"][@"suitList"]];
            
            
            NSString * str =[NSString stringWithFormat:@"%@",data[@"data"][@"userSuit"][@"status"]];
            if ([str isEqualToString:@"0"]) {// 没购买
                topView.BuyLBName.text = @"未购买套餐";

            }else if([str isEqualToString:@"1"]){// 进行时
        topView.BuyLBName.text = [NSString stringWithFormat:@"已购买\"%@\"套餐",data[@"data"][@"userSuit"][@"name"]];

            
                seleTaoCanID =  [NSString stringWithFormat:@"%@",data[@"data"][@"userSuit"][@"id"]];
            }else {// 过期
                topView.BuyLBName.text = [NSString stringWithFormat:@"\"%@\"套餐已过期",data[@"data"][@"userSuit"][@"name"]];
                seleTaoCanID =  [NSString stringWithFormat:@"%@",data[@"data"][@"userSuit"][@"id"]];

            }
            for (int i  = 0 ; i< DataArray.count; i++) {
                if ([seleTaoCanID isEqualToString:DataArray[i][@"id"]]) {
                    selectIndex = i;
                }
            }
            

            [self UpdataUI];
            [_TV reloadData];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    





}
-(void)UpdataUI{


    _TV.frame = CGRectMake(0, topView.bottom, ConentViewWidth, DataArray.count * 30);
    buyBtn.frame = CGRectMake(20, _TV.bottom+ 20, ConentViewWidth - 40, 40);
    bottomView.frame = CGRectMake(0, buyBtn.bottom + 20, ConentViewWidth, 277);
    BackScroll.contentSize= CGSizeMake(ConentViewWidth, bottomView.bottom);
 }


//内购
// 根据id进行购买商品
- (void)buyProductsWithId:(NSString *)productsId andQuantity:(NSInteger)quantity {
    self.productsId = productsId;
    self.quantity = quantity;
    if ([SKPaymentQueue canMakePayments]) {
        //允许程序内付费购买
        [self RequestProductData:@[self.productsId]];
    } else {
        //您的手机没有打开程序内付费购买
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"您的手机没有打开程序内付费购买" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alerView show];
    }
}
- (void)RequestProductData:(NSArray *)productsIdArr {
    //请求对应的产品信息
    NSSet *nsset = [NSSet setWithArray:productsIdArr];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}

//delegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    //收到产品反馈信息
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int) [myProduct count]);
    // populate UI
    for (SKProduct *product in myProduct) {
        [self updateProductPriceWithId:product.productIdentifier andPrice:product.price];
        if ([[product.priceLocale objectForKey:NSLocaleCurrencyCode] isEqualToString:@"CNY"]) {
            self.currencyCode = @"￥";
        } else {
            self.currencyCode = [product.priceLocale objectForKey:NSLocaleCurrencySymbol];
        }
    }
    //发送购买请求
    for (SKProduct *prct in myProduct) {
        if ([self.productsId isEqualToString:prct.productIdentifier]) {
            SKMutablePayment *payment = nil;
            payment = [SKMutablePayment paymentWithProduct:prct];
            payment.quantity = self.quantity;
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}

- (void)updateProductPriceWithId:(NSString *)productIdentifier andPrice:(NSDecimalNumber *)price{
    NSLog(@"productIdentifier == %@",productIdentifier);
    NSLog(@"price == %@",price);
}

// 内购 结果
#pragma mark - SKPaymentTransactionObserver
//----监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    //交易结果
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                //交易完成
                [self completeTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed: {
                //交易失败
                [self failedTransaction:transaction];
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"交易失败" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                [alerView show];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                //已经购买过该商品
                [self restoreTransaction:transaction];
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"已经购买过该商品" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                [alerView show];
            }
                break;
            case SKPaymentTransactionStatePurchasing: {
                //商品添加进列表
                NSLog(@"商品添加进列表");
            }
                break;
            case SKPaymentTransactionStateDeferred: {
                NSLog(@"SKPayment Transaction State Deferred");
            }
                break;
            default:
                break;
        }
    }
}
- (void)failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled) { }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易恢复处理");
}
// 交易成功后台验证
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"-----completeTransaction--------");
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            [self provideContent:bookid];}
    }
}

 //记录交易
- (void)recordTransaction:(NSString *)product{
    NSLog(@"记录交易--product == %@",product);
}
//处理下载内容
- (void)provideContent:(NSString *)product{
    NSLog(@"处理下载内容--product == %@",product);
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
