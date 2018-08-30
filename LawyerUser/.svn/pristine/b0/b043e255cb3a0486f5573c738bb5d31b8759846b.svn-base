//
//  QJMapSearchViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/14.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMapSearchViewController.h"
#import "QJFindingCell.h"
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "WYFindViewModel.h"
#import "WYFindTableViewCell.h"
#import "QJlawyerDetailsViewController.h"

#import "QJSelectArea.h"
#import "QJSelectDatePickView.h"
@interface QJMapSearchViewController (){

    QJSelectArea * selectAreaPick;//地区选择视图
    QJSelectDatePickView * selectPick;
    NSString *AreaStr;
    NSMutableDictionary * valueDicing;

/// 大头针数据
     NSMutableArray * annotations;
    UIButton * rightBtn;
    
    NSMutableArray *listArr;
    NSString *areaId;
    NSUserDefaults * userdefautlt;
    NSString * cityName;
    int numbers;
    int b;
}

@end

@implementation QJMapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    areaId =  @"";
    userdefautlt = [NSUserDefaults standardUserDefaults];
    
    valueDicing = [[NSMutableDictionary alloc ]init];
    numbers = 0;
    b = 0;
    DataArray = [NSMutableArray array];
    listArr = [NSMutableArray array];
    [self makeTV];
    [self makeSegment];
    
    //add tableview
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0,_mapView.bottom, ConentViewWidth , ConentViewHeight - _mapView.bottom - 49 )style:UITableViewStylePlain];
    _tv.tableFooterView = [[UIView alloc]init];
    _tv.delegate= self;
    _tv.dataSource = self;
    
    _tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        numbers = 0;
        b = 0;
        [self makeAppLawyerFinds];
    }];
    
    _tv.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        b = 0;
        [self makeAppLawyerFinds];
    }];
    
    [self.view addSubview:_tv];
    //end
    
    
    
    // 定位
    _locServiece =[[BMKLocationService alloc]init];
    _locServiece.delegate = self;
    [_locServiece startUserLocationService];
    
    self.navigationItem.hidesBackButton = YES;
    
    
    
    
    
    rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 70, 30);
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    areaId = [NSString changeNullString: [userdefautlt  objectForKey:@"AreaId"]];
    cityName = [NSString changeNullString:[ userdefautlt   objectForKey:@"cityName"]];
    if (cityName.length == 0) {
        cityName = @"区域";
    }
     [rightBtn setTitle:cityName forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(RightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self makeAppLawyerFinds];

    
    

    // Do any additional setup after loading the view.
}

- (void)makeAppLawyerFinds{
    
    numbers ++ ;
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Lawyerfinds
    
    NSDictionary * valudic;
    if ([Utile stringIsNil:lonStr]||[Utile stringIsNil:latStr]) {
        valudic  = @{@"lng":@"120.299",@"lat":@"31.568",@"p":[NSString stringWithFormat:@"%d",numbers],@"area_id":areaId};
    }else{
        valudic  = @{@"lng":lonStr,@"lat":latStr,@"p":[NSString stringWithFormat:@"%d",numbers],@"area_id":areaId};
    }
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"条件查找%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSArray *arrays = [NSArray arrayWithArray:data[@"data"][@"lawyerList"]];
            if (arrays.count > 0) {
                if (numbers == 1) {
                    [listArr removeAllObjects];
                    [DataArray removeAllObjects];
                    [listArr addObjectsFromArray:arrays];
                    for (NSDictionary *dica in arrays) {
                        WYFindViewModel *models = [WYFindViewModel yy_modelWithDictionary:dica];
                        [DataArray addObject:models];
                    }
                }else{
                    [listArr addObjectsFromArray:arrays];
                    for (NSDictionary *dica in arrays) {
                        WYFindViewModel *models = [WYFindViewModel yy_modelWithDictionary:dica];
                        [DataArray addObject:models];
                    }
                 }
            }else{
                if (listArr.count == 0) {
                    [self showHint:@"暂无数据！"];
                }else{
                    [self showHint:@"暂无更多数据！"];
                }
                numbers -- ;
            }
          }else{
            
            numbers--;
            [self showHint:@"暂无数据！"];
            
        }
        
        [self makeAnnotationViewsArray];
        NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
        [self showHint:msg];
     
        if ( DataArray.count == 0 ||[str isEqualToString:@"1001"]) {
            [DataArray removeAllObjects];
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:30];
        }else{
            [self hintNodataView];
        }
        [_tv.mj_header endRefreshing];
        [_tv.mj_footer endRefreshing];
        [_tv reloadData];
        [self hideHud];
    } failure:^(NSError *error) {
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:30];
        }else{
            [self hintNodataView];
        }
        

        [self hideHud];
        numbers -- ;
        [_tv.mj_header endRefreshing];
        [_tv.mj_footer endRefreshing];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"条件查找%@",error);
    }];
    
}
-(void)RemoveVIew:(UIButton *)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        selectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        [selectAreaPick removeFromSuperview];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    rightBtn.selected = NO;
    [selectAreaPick removeFromSuperview];
//    if (selectPick) {
//        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
//    }
}
-(void)RightAction:(UIButton *)sender{
    sender.selected =! sender.selected;
    
    if (sender.selected) {
        if (!selectPick) {
            UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
            [backBtn addTarget:self action:@selector(RemoveVIew:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backBtn];
            selectAreaPick =[[QJSelectArea alloc]initWithFrame:CGRectMake(0, ConentViewHeight, ConentViewWidth, 250)];
            
            [self.view addSubview:selectAreaPick];
            
            __block  QJSelectArea *BlockselectAreaPick = selectAreaPick;
            __block  UITableView * WeakTv = _tv;
            
            selectAreaPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString, NSString *prvId, NSString *cityId, NSString *AreaId) {
                [backBtn removeFromSuperview];
                
                if (IsCertain) {
                    NSLog(@"区域 %@",dateString);
                    
                    AreaStr = dateString;
                    
                    NSArray * CityNameArray =[dateString componentsSeparatedByString:@" "];
                    cityName  = CityNameArray[1];
                      numbers = 0;
                     b = 0;
                     areaId =AreaId;
                    [userdefautlt setObject:cityName  forKey:@"cityName"];
                    [ userdefautlt  setObject:areaId  forKey:@"AreaId"];
                    [userdefautlt synchronize];
                    [rightBtn setTitle:cityName forState:UIControlStateNormal];

                    [self makeAppLawyerFinds];

                    
                    [_tv reloadData];
                    
                }else{
                    
                    
                }
                [UIView animateWithDuration:0.5 animations:^{
                    BlockselectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
                } completion:^(BOOL finished) {
                    
                    [BlockselectAreaPick removeFromSuperview];
                }];
            };
            
            [UIView animateWithDuration:0.5 animations:^{
                selectAreaPick.frame = CGRectMake(0, ConentViewHeight - 250 - 49, ConentViewWidth, 250);
            }];

    }
   
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            selectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
        }];
    }

}


#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    [rightBtn setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)makeSegment{
    
    NSArray * SgArray =[[NSArray alloc] initWithObjects:@"条件查找",@"地图查找",nil];
    UISegmentedControl * sg =[[UISegmentedControl alloc]initWithItems:SgArray];
    
    sg.frame = CGRectMake(0, 7, 200, 30);
    sg.clipsToBounds  = YES;
    sg.selectedSegmentIndex = 1;
    sg.tintColor =MAINCOLOR;
    [sg addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                             NSForegroundColorAttributeName: [UIColor colorWithRed:90/255.0 green:181/255.0 blue:233/255.0 alpha:1]};
    [sg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]};
    [sg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    UIView * topVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    [topVIew addSubview:sg];
    self.navigationItem.titleView   = topVIew;
    
}
-(void)makeTV{
    
    _mapView =[[BMKMapView alloc ]initWithFrame:CGRectMake(0, 0,ConentViewWidth, 200)];
    
    [_mapView setZoomLevel:15];
    [_mapView setMapType:BMKMapTypeStandard];

    [self.view addSubview:_mapView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WYFindTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"WYFindTableViewCell" owner:self options:nil]lastObject];
    }
    cell.model = DataArray[indexPath.section];
    cell.distanceLab.text = [NSString stringWithFormat:@"%@km",listArr[indexPath.section][@"range"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 132;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == DataArray.count- 1) {
        return 0.01;
    }else{
        return 10;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath.row  = %ld",(long)indexPath.row);
    QJlawyerDetailsViewController * lvc= [[QJlawyerDetailsViewController alloc]init];
    lvc.lawyerID = [NSString stringWithFormat:@"%@",listArr[indexPath.section][@"id"]];
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];
    
}




-(void)sgAction:(UISegmentedControl *)sender{
    NSLog(@"seconder");

    if (sender.selectedSegmentIndex == 0) {
        [self.navigationController popViewControllerAnimated:NO];

    }else{
        
    }
    
    
}


// 创建annotationView 数据源

-(void)makeAnnotationViewsArray{
    annotations = [[NSMutableArray alloc]init];
//    
//    for (int i  = 0 ; i< 3; i++) {
//        
//        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//        CLLocationCoordinate2D  coorndiate  = CLLocationCoordinate2DMake(31.465909, 120.267787 + i);
//        item.coordinate =  coorndiate;
//        
//        item.title =  [NSString stringWithFormat:@"第%d个大头针",i];
//        NSLog(@"== %f" ,coorndiate.longitude);
//        [annotations addObject:item];
//        [_mapView addAnnotation:item];
//        
//        
//    }
    
    annotations = [[NSMutableArray alloc]init];
  
    for (int i  = 0 ; i< listArr.count; i++) {
        NSString *code = [NSString stringWithFormat:@"%@",listArr[i][@"code"]];
        if ([Utile stringIsNil:code]) {
            code = [NSString stringWithFormat:@"34.7794742932,113.557281425"];
        }
        NSArray *array = [code componentsSeparatedByString:@","];
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D  coorndiate  = CLLocationCoordinate2DMake([array[0]   floatValue], [array[1] floatValue]);
        //CLLocationCoordinate2D  coorndiate  = CLLocationCoordinate2DMake(31.465909, 120.267787 + i);
        item.coordinate =  coorndiate;
        
        item.title =  [NSString stringWithFormat:@"%@",listArr[i][@"id"]];
        NSLog(@"== %f" ,coorndiate.longitude);
        [annotations addObject:item];
    }
    [_mapView addAnnotations:annotations];



}

//返回 annotationview
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{


    BMKAnnotationView * AccntationView;
    
    AccntationView  =[[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"cell"];
    AccntationView.size = CGSizeMake(25, 25);
    
    
    SDWebImageDownloader *dowen = [SDWebImageDownloader sharedDownloader];
    [dowen downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,listArr[b][@"thumb"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        UIImage *imag = [self OriginImage:image scaleToSize:CGSizeMake(60, 60)];
        imag = [self circleImage:imag];
        AccntationView.image = imag;
    }];
    
    
    
    AccntationView.tag = b;
    [_mapView selectAnnotation:annotation animated:NO];
    
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)];
    popView.backgroundColor = [UIColor whiteColor];
    //设置弹出气泡图片
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi"]];
    
    image.frame = CGRectMake(0, 0, 150, 100);
    image.backgroundColor = [UIColor whiteColor];
    [popView addSubview:image];
    //自定义显示的内容
    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 140, 20)];
    driverName.text = @"律师详情";
    driverName.backgroundColor = [UIColor clearColor];
    driverName.font = [UIFont systemFontOfSize:16];
    driverName.textColor = [UIColor blackColor];
    driverName.textAlignment = NSTextAlignmentLeft;
    [popView addSubview:driverName];
    UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 140, 80)];
    carName.text = [NSString stringWithFormat:@"姓名：%@\n公司：%@\n查看详情",listArr[b][@"name"],listArr[b][@"company"]];
    carName.textColor = [UIColor blackColor];
    
    [Utile setUILabel:carName data:[NSString stringWithFormat:@"姓名：%@\n公司：%@\n",listArr[b][@"name"],listArr[b][@"company"]] setData:@"查看详情" color:MAINCOLOR font:14 underLine:NO];
    
    
    carName.backgroundColor = [UIColor clearColor];
    carName.numberOfLines = 0;
    carName.font = [UIFont systemFontOfSize:14];
    
    // carName.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:carName];
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
    popView.tag = b;
    pView.frame = CGRectMake(0, 0, 150, 100);
    AccntationView.paopaoView = pView;
    
    b ++ ;
    return  AccntationView;
 
    
}
#pragma mark 图片压缩
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}
#pragma mark 图片剪切成圆形
-(UIImage*) circleImage:(UIImage*) image{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width , image.size.height );
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"%ld **%@",(long)view.tag,view.annotation.title);
    
    NSLog(@"选中了 一个大头针");
}
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    NSLog(@"点击气泡%ld**%@",(long)view.tag,view.annotation.title);
    QJlawyerDetailsViewController * lvc= [[QJlawyerDetailsViewController alloc]init];
    lvc.lawyerID = [NSString stringWithFormat:@"%@",listArr[view.tag][@"id"]];
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];


}
#pragma mark     _locServiewdelegate 
// 位置方向改变信息   不作处理
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation{


}
// 处理坐标更新
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    if (userLocation  != nil) {
        
        
        _mapView.showsUserLocation = YES;//显示定位图层
        
        // 当中心点偏移量比较大的时候再去 请求 用手势？
        // 设置中心点坐标
        _mapView.centerCoordinate = userLocation.location.coordinate;
        userLocation.title = @"我的位置";
        
        userLocation.subtitle =@"没有车";
        [_mapView updateLocationData:userLocation];
        
        [_mapView addAnnotations:annotations];
        
        
        
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    

    }else{
    
        NSLog(@"定位失败！");
    
    }
    NSLog(@"位置更新 结束定位");
    [_locServiece stopUserLocationService];
}


#pragma mark     _mapViewdelegate
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
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
