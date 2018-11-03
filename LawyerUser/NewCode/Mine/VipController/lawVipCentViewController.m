//
//  lawVipCentViewController.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/2.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipCentViewController.h"
#import "lawVipTopView.h"
#import "lawVipCentServiceCell.h"
#import "lawVipFootView.h"
@interface lawVipCentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSMutableArray * CollectDataArray;
}

@property (strong ,nonatomic) UICollectionView * collectionView;
@property (strong ,nonatomic) lawVipFootView * collectionFootView;

@property (strong ,nonatomic) lawVipTopView * collectionTopView;
@end

@implementation lawVipCentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    [self prefersStatusBarHidden];
    self.view.backgroundColor =[UIColor whiteColor];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    CollectDataArray=[[NSMutableArray alloc]init];
    [self requestData];
    [self.collectionFootView.FirstView whenTapped:^{
        NSLog(@"使用记录");
    }];
    [self.collectionFootView.SecondView whenTapped:^{
        NSLog(@"充值记录");
    }];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}
// 替换baseVC 的方法
-(void)initCustomNavigationBar{
    
}
-(void)addBackButton{
    
}

-(lawVipFootView *)collectionFootView{
    if (!_collectionFootView) {
        _collectionFootView =[[[NSBundle mainBundle]loadNibNamed:@"lawVipFootView" owner:self options:nil]lastObject];
     }
    
    return _collectionFootView;
    
}
-(lawVipTopView *)collectionTopView{
    if (!_collectionTopView) {
        _collectionTopView =[[[NSBundle mainBundle]loadNibNamed:@"lawVipTopView" owner:self options:nil]lastObject];
      }
    
    return _collectionTopView;
}

#pragma mark  设置CollectionView的的参数
- (void) initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH,self.collectionTopView.height);
    flowLayout.footerReferenceSize  = CGSizeMake(SCREENWIDTH, self.collectionFootView.height);
    [self.collectionTopView initSubview];
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 1, 0, 0);//设置间隔
//    flowLayout.itemSize=CGSizeMake((SCREENWIDTH - 26) / 3, 84);  //设置每个单元格的大小
    flowLayout.minimumLineSpacing=0; //设置每一行的间距
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(13, 0, SCREENWIDTH  - 26,SCREENHEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.clipsToBounds = NO ;
    [self.view addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([lawVipCentServiceCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    //    注册头视图
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header removeAllSubviews];
        [header addSubview:self.collectionTopView];

        header.left  =  -13;
//        header.width = SCREENWIDTH;
         header.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        header.clipsToBounds = NO ;
        return header;
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
            [header removeAllSubviews];
            [header addSubview:self.collectionFootView];
            
            header.left  =  -13;
            //        header.width = SCREENWIDTH;
             header.clipsToBounds = NO ;
            return header;
        }
        
    }
    
    return nil;
}

 #pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
        return CollectDataArray.count;
 
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    lawVipCentServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if(indexPath.row%3 == 2){
        cell.RightLineView.hidden = YES ;
    }else{
        cell.RightLineView.hidden = NO ;
    }
    cell.model =CollectDataArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.DesLB.text= [NSString stringWithFormat:@"%@",cell.model.num];
    }
     return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
    
}
#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((SCREENWIDTH - 27)/3 ,84);
}

- (void)requestData {
    
    
    [self showHint:nil  inView:self.view];
    
    //action、value
    NSDictionary *valuedic = @{
                               @"uid":UserId,
                               };
    
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewUserVip ;
    [dic setValue:base64String forKey:@"value"];
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        [self hideHud];
        if ([responseObjeck[@"status"] integerValue] == 0) {
           
            for (NSDictionary * dic in responseObjeck[@"data"]) {
                lawVipModel * model  =[lawVipModel yy_modelWithJSON:dic];
                [self->CollectDataArray addObject:model];
            }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
