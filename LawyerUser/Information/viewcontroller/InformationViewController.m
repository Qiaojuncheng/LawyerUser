//
//  InformationViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "InformationViewController.h"
#import "QJlawyerDetailsViewController.h"
#import "xsqbanner.h"
#import "QJInfoDateCell.h"
#import "QJScrollItemView.h"

#import "QJNewCataModel.h"
#import "QJInfoCell.h"

#import "QJInfoDetailVC.h"

static UIWindow *__sheetWindow = nil;

@interface InformationViewController ()<QjScrollItemdelegate>{
    
    NSMutableArray *_data1; // 时间数组
    UITableView *DateTv;// 时间的TV；
    UIButton * selectDateBtn;// 选中的时间 //一月内 按钮
    
    
    //UIButton * backBtn;// 用作选时间的背景。
    
    UIView * topView;
//    xsqbanner * BannerView;
    UIImageView *imageview;
    
    NSInteger  SelectDate;// 选中的日期  1 2 3 4 5 6 ； 默认传的是1  一个月之内
    QJNewCataModel *  SelectModel;// 选中的分类后台给数据;
    NSMutableArray  * cateArray;
    QJScrollItemView * scrollView;
    UIView *heiseView;
    UIImageView *sanImg;
    NSInteger selectView;
    
    
    

 }

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBackColor;
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = @"法律资讯";
    SelectDate = 1;
    cateArray =[[NSMutableArray alloc]init];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(didViewBlockView)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self maketopItem];
    
     [self makeCata];
    // Do any additional setup after loading the view.
}
-(void)makeCata{

    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJNEWGETCATE
//    NSDictionary * valueDic  = @{@"SelectDate":[NSString stringWithFormat:@"%ld",SelectDate],@"Selecttype":[NSString stringWithFormat:@"%ld",(long)Selecttype]};
//    //    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
//    
//    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
//    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            for (NSDictionary *  dic in data[@"data"]) {
                QJNewCataModel* model =[QJNewCataModel yy_modelWithDictionary:dic];
                [cateArray addObject:model];
            }
            if (cateArray.count >  0) {
                SelectModel  = cateArray[0];
            }
            scrollView.IteamArray  = cateArray;
            [self makeData];
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


-(void)makeData{


    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJNEW
    NSDictionary * valueDic  = @{@"tid":[NSString stringWithFormat:@"%ld",SelectDate],@"cid":[NSString stringWithFormat:@"%@",SelectModel.id]};
    //    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        [DataArray removeAllObjects];
         NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
      
            for (NSDictionary * dic in data[@"data"]) {
                 QJNewModel * model =  [QJNewModel yy_modelWithJSON:dic];
                [DataArray addObject:model];
            }
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [_tv reloadData];
        [self hideHud];
        
        
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:50];
        }else{
            [self hintNodataView];
        }
        
        
    } failure:^(NSError *error) {
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:50];
        }else{
            [self hintNodataView];
        }
        
        [self hideHud];
         NSLog(@"%@",error);
    }];



}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == DateTv) {
        return  _data1.count;
    }
    return DataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == DateTv) {
    
        QJInfoDateCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) {
            cell  = [[[NSBundle mainBundle]loadNibNamed:@"QJInfoDateCell" owner:self options:nil]lastObject];

         }
        cell.DateLB.text = _data1[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (selectView == indexPath.row) {
            cell.DateLB.textColor = MAINCOLOR;
        }else{
            cell.DateLB.textColor =  [UIColor blackColor];
        }
         return cell;

    
    
    }

    QJInfoCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"QJInfoCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.model = DataArray[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == DateTv) {
        return  40;
    }
    return 92;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    heiseView.hidden = YES;
    DateTv.hidden = YES;
    sanImg.hidden = YES;
    
    if (tableView == DateTv) {

        selectView = indexPath.row;
        NSLog(@"indexPath.row  = %@",_data1[(long)indexPath.row]);
        //[selectDateBtn setTitle:_data1[(long)indexPath.row] forState:UIControlStateNormal];
        SelectDate  =  indexPath.row + 1 ;
        [self makeData];
        [DateTv reloadData];
        
    }else{
        
    QJNewModel * model = DataArray[indexPath.row];
    QJInfoDetailVC * lvc= [[QJInfoDetailVC alloc]init];
    lvc.infoId =model.id;
    lvc.title  =  @"法律资讯-详情";
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];
    
     }
}





-(void)maketopItem{
     _data1 = [NSMutableArray arrayWithObjects:@"一月内",@"两月内",@"三月内",@"四月内",@"五月内", nil];
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,ConentViewWidth , ConentViewWidth *0.618)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    
    
    
    DataArray = [[NSMutableArray alloc]init];
    
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0,topView.bottom +10, ConentViewWidth , ConentViewHeight - topView.height - 49 - 10) style:UITableViewStylePlain];
    
    _tv.tableFooterView =[[UIView alloc]init];
    _tv.delegate= self;
    _tv.dataSource = self;
    
    [self.view addSubview:_tv];
    
    
    
//    NSArray * ImageArray= @[@"http://pic.58pic.com/58pic/13/70/90/29358PICQjG_1024.jpg"];
//      BannerView = [xsqbanner direcWithtFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewWidth *0.618 - 50) ImageNameArr:ImageArray AndImageClickBlock:^(NSInteger index) {
//        NSLog(@"sddds");
//        
//        
//    }];
     imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewWidth *0.618 - 50)];
    imageview.image =[UIImage imageNamed:@"l-info-banner"];
    [topView addSubview:imageview];

    UIView *middleView =[[UIView alloc ]initWithFrame:CGRectMake(0, imageview.bottom, ConentViewWidth, 50)];
    
    
    [topView addSubview:middleView];
    topView.height  = middleView.bottom;
    
    
    // 选中时间的Btn
    selectDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectDateBtn.frame = CGRectMake(0, 0, ConentViewWidth/4 , middleView.height);
    [selectDateBtn setTitle:@"一月内" forState:UIControlStateNormal];
    [selectDateBtn setImage:[UIImage imageNamed:@"下拉箭头"] forState:UIControlStateNormal];
//    CGFloat endgValuer = selectDateBtn.width - 30;
//    [selectDateBtn setImageEdgeInsets:UIEdgeInsetsMake(0, endgValuer, 0, -endgValuer)];
//    [selectDateBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 25)];
//
    CGFloat imageWidth = selectDateBtn.imageView.bounds.size.width;
     CGFloat labelWidth = selectDateBtn.titleLabel.bounds.size.width;
    
    selectDateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    selectDateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    
    
    
    
//    UILabel * linLB =[[UILabel alloc]initWithFrame:CGRectMake(selectDateBtn.right, 0,1 , selectDateBtn.height)];
//    linLB.backgroundColor = MainBackColor;
//    [middleView addSubview:linLB];
    
    
//    [selectDateBtn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
//    [selectDateBtn addTarget:self action:@selector(BrnAction) forControlEvents:UIControlEventTouchUpInside];
//    selectDateBtn.hidden = YES;
    
    // scrollView =[[QJScrollItemView alloc]initWithFrame:CGRectMake(selectDateBtn.right +1, 0, self.view.width - selectDateBtn.right -1, selectDateBtn.height)];
    scrollView =[[QJScrollItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.width , selectDateBtn.height)];
    scrollView.delegate = self;
     [middleView addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    //
    heiseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, [UIScreen mainScreen].bounds.size.height)];
    heiseView.backgroundColor = [UIColor colorWithColor:[UIColor whiteColor] alpha:0.0f];
    [[[UIApplication sharedApplication] keyWindow] addSubview:heiseView];
    heiseView.hidden = YES;

    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didViewBlockView)];
    [heiseView addGestureRecognizer:tapGesture];
    [self.view addSubview:heiseView];
    //

  
    
    DateTv =[[UITableView alloc]initWithFrame:CGRectMake(ConentViewWidth - ConentViewWidth/3,8,ConentViewWidth/3 - 10,200) style:UITableViewStylePlain];
    DateTv.delegate= self;
    DateTv.dataSource= self;
    DateTv.tableFooterView =[[UIView alloc]init];
    DateTv.hidden = YES;
    DateTv.layer.cornerRadius = 5;
    DateTv.layer.masksToBounds = YES;
    DateTv.layer.borderColor = LINECOLOR.CGColor;
    DateTv.layer.borderWidth = 1;
    [self.view addSubview:DateTv];
    //
    sanImg = [[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth - 35, 0, 20, 10)];
    sanImg.image = [UIImage imageNamed:@"sanjiao"];
    [self.view addSubview:sanImg];
    sanImg.hidden = YES;
    //
    
    //[middleView addSubview:selectDateBtn];
    
    
//
    
    
    

}
-(void)QJScrollItemViewseleIndex:(NSInteger)index{
    SelectModel = cateArray[index];
    [self makeData];
}
#pragma mark  一月内按钮点击事件
-(void)didViewBlockView{
    NSLog(@"qqqqq");
    heiseView.hidden = !heiseView.hidden;
    DateTv.hidden =! DateTv.hidden;
    sanImg.hidden =! sanImg.hidden;
}
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    heiseView.hidden = YES;
    DateTv.hidden =YES;
    sanImg.hidden = YES;
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
