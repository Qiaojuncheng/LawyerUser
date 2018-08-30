//
//  QJApplePayViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/10/31.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJApplePayViewController.h"
#import "QJApplePayCell.h"
@interface QJApplePayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView * _collectionView;
     NSMutableArray * PayTypeArray;
    UIButton * BuyBtn;
}

@end

@implementation QJApplePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    PayTypeArray =[[NSMutableArray alloc]initWithObjects:@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元",@"10元", nil];
    [self makeUI];
    // Do any additional setup after loading the view.
}
-(void)makeUI{


//此处必须要有创见一个UICollectionViewFlowLayout的对象
UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
//同一行相邻两个cell的最小间距
layout.minimumInteritemSpacing = 5;

//最小两行之间的间距
layout.minimumLineSpacing = 10;

_collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, ConentViewWidth - 20, ConentViewHeight - 120) collectionViewLayout:layout];
    _collectionView.backgroundColor = MainBackColor;
    
_collectionView.backgroundColor=[UIColor whiteColor];
_collectionView.delegate=self;
_collectionView.dataSource=self;
//这个是横向滑动
//layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
[self.view addSubview:_collectionView];

/*
 *这是重点 必须注册cell
 */
//这种是xib建的cell 需要这么注册
UINib *cellNib=[UINib nibWithNibName:@"QJApplePayCell" bundle:nil];
[_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"QJApplePayCell"];
    
    BuyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BuyBtn.frame = CGRectMake(10,ConentViewHeight - 100 ,ConentViewWidth - 20, 40);
 
    [BuyBtn setTitle:@"确定" forState:UIControlStateNormal];
    [BuyBtn setBackgroundColor:MAINCOLOR];
    [BuyBtn setTintColor:[UIColor colorWithHex:0xffffff]];
    [BuyBtn addTarget:self action:@selector(BuyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [Utile makeCorner:4 view:BuyBtn];
    [self.view addSubview:BuyBtn];
    
 }
 //一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return PayTypeArray.count;
}
//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QJApplePayCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"QJApplePayCell" forIndexPath:indexPath];
    cell.ConcentLB.text=[NSString stringWithFormat:@"%@",PayTypeArray[indexPath.row]];
     return cell;
}

 //定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 30);
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
 }
-(void)BuyBtnAction:(UIButton *)sender{
    
    
    NSLog(@"购买");
    
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
