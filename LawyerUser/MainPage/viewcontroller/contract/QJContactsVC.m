//
//  QJContactsVC.m
//  Lawyer
//
//  Created by MYMAc on 2017/8/3.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJContactsVC.h"
#import "QJNearCell.h"
#import "QJlawyerDetailsViewController.h"
#import "QJMainTapShwoView.h"
#import "QJContactView.h"
#import "QJMiddleBuyView.h"
#import "QJSelectItemView.h"
#import "QJVipVc.h"
#import "WYChoseFileQJViewController.h"
#import "AFNetworking.h"
#import "QJLayerLettersmiddleView.h"
#import "QJPayViewController.h"
#import "DatePickerView.h"

@interface QJContactsVC ()<UITextViewDelegate,UITextFieldDelegate,DatePickerViewDelegate>{
    
    UIView * _backWindowView;
    
    QJLayerLettersmiddleView * Topleshowview;
    DatePickerView * selectPick;
    NSString * timeStr;
    NSString * PriceStr;
    
    NSString * lawyer_field ; // 案件领域
  NSString *  party_information ; // 当事人信息
    
    NSString * typeStr;
    NSMutableArray *DataArray1;
    NSMutableArray *listArr;
    NSString *moneyStr;//服务费
    QJMiddleBuyView * middleBuyview;
    QJContactView * middleshowview;
    
    NSDictionary *fileUrl;
    NSString *WenName;
    NSString *WenPath;
    NSString *payPrice;
    
}


@property (strong, nonatomic)   UIView *TvHeaderView;


@end

@implementation QJContactsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合同审查";
    DataArray1 = [NSMutableArray array];
    listArr = [NSMutableArray array];
    [self makeConsultGetData];
    //[self makeBackItem];
    [self makeTV];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark  案件类型以及服务费
- (void)makeConsultGetData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultgetCategory
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"案件类型以及服务费%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [DataArray1 addObjectsFromArray:data[@"data"][@"categoryList"]];
            
            for (NSDictionary *dica in DataArray1) {
                [listArr addObject:[dica objectForKey:@"cat_name"]];
            }
            
            middleBuyview.ShwoMessageLB.text = [NSString stringWithFormat:@"服务费%@元，购买套餐可以免费服务",data[@"data"][@"config"]];
            [Utile setUILabel:middleBuyview.ShwoMessageLB data:[NSString stringWithFormat:@"服务费%@元，",data[@"data"][@"config"]] setData:@"购买套餐" color:MAINCOLOR font:14 underLine:NO];
            payPrice = [NSString stringWithFormat:@"%@",data[@"data"][@"config"]];
            
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [_TV reloadData];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"案件类型以及服务费%@",error);
    }];
    
}

-(void)makeTV{
    
   // dataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    _TV =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight ) style:UITableViewStylePlain];
    _TV.delegate = self;
    _TV.dataSource= self;
    _TV.backgroundColor = MainBackColor;
    _TV.tableFooterView = [[UIView alloc]init];
    _TV.tableHeaderView = [self makeTvHeaderView ];
    [self.view addSubview:_TV];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    QJNearCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"celll"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"QJNearCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QJlawyerDetailsViewController * lvc= [[QJlawyerDetailsViewController alloc]init];
    
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];
    
    NSLog(@"indexPath.row  = %ld",(long)indexPath.row);
    
}

-(UIView *)makeTvHeaderView{
    
    //NSArray * typtArray =@[@"纠纷",@"财产纠纷",@"需要类别",@"请求",@"本地",@"类型",];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 480)];
    headerView.backgroundColor =MainBackColor;
    QJMainTapShwoView * topshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJMainTapShwoView" owner:self options:nil]lastObject];
    topshowview.topImage.image = [UIImage imageNamed:@"l-file-2"];
    topshowview.imageView.hidden = YES;
    topshowview.oneLab.text = @"合同审查";
    topshowview.frame = CGRectMake(0, 0, ConentViewWidth, topshowview.height);
    [topshowview.WenshuView whenTapped:^{
        NSLog(@" 文书")  ;
    }];
    
    [headerView addSubview:topshowview];
    
    
    
    Topleshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJLayerLettersmiddleView" owner:self options:nil]lastObject];
    Topleshowview.frame = CGRectMake(0,  topshowview.bottom , ConentViewWidth, Topleshowview.height);
    Topleshowview.PriceTextField.delegate = self;
    [headerView addSubview:Topleshowview];
    Topleshowview.AreaLb.text = @"请选择案件领域";
    [Topleshowview.AreaLb whenTouchedUp:^{
        NSLog(@"类型");
        QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt= @"案件领域";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:listArr] ;
        seleView.selectWithIndexBlcik = ^(int index) {
 
            typeStr = DataArray1[index][@"cat_id"];
            Topleshowview.AreaLb.text =listArr[index];
        };
        [self.view addSubview:seleView];
        [seleView showView];
        
    }];
    
    NSArray * typtArray =@[@"个人",@"公司"];
    NSArray *intArray = @[@"1",@"2"];

    Topleshowview.PerInfoLB.text= @"请选择当事人信息";
    [Topleshowview.PerInfoLB whenTouchedUp:^{
        QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt= @"当事人信息";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:typtArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
            party_information = intArray[index];
            Topleshowview.PerInfoLB.text =typtArray[index];
        };
         [self.view addSubview:seleView];
        [seleView showView];
        
    }];
    
    Topleshowview.TimeLb.text = [NSString stringWithFormat:@"请选择交付时间"];
    [Utile addClickEvent:self action:@selector(diChoseTime) owner:Topleshowview.TimeLb];

    
    [headerView addSubview:Topleshowview];
    
    
    
    
    middleshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJContactView" owner:self options:nil]lastObject];
    middleshowview.frame = CGRectMake(0,  Topleshowview.bottom +10, ConentViewWidth, middleshowview.height);
    
    middleshowview.shangLab.layer.masksToBounds = YES;
    middleshowview.shangLab.layer.cornerRadius = 4;
    [Utile addClickEvent:self action:@selector(didFiles) owner:middleshowview.shangLab];
    
    middleshowview.PltextVeiw.placeholderText = @"请描述您的合同";
    middleshowview.TypeLb.text = @"请选择合同类型";
    [headerView addSubview:middleshowview];
 
    
    middleBuyview =[[[NSBundle mainBundle] loadNibNamed:@"QJMiddleBuyView" owner:self options:nil]lastObject];
    middleBuyview.frame = CGRectMake(0, ConentViewHeight -  middleBuyview.height  , ConentViewWidth, middleBuyview.height);
    [headerView addSubview:middleBuyview];
    [middleBuyview.ShwoMessageLB whenTapped:^{
        NSLog(@"tap");
        QJVipVc * sevc =[[QJVipVc alloc]init];
        sevc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:sevc animated:YES];
        
    }];
    
    [middleBuyview.BaojiaButton whenTapped:^{
        NSLog(@"报价buttonwang");
        [self tijiaoHeTong];
        
    }];
    
    if (middleBuyview.top  < middleshowview.bottom ) {
        middleBuyview.frame = CGRectMake(0, middleshowview.bottom + 20, ConentViewWidth, middleBuyview.height);
    }

    headerView.height  = middleBuyview.bottom;;
    
    return headerView;
}
#pragma mark 选择文件上传
- (void)didFiles{
    NSLog(@"选择文件上传!");
    WYChoseFileQJViewController *filess  = [[WYChoseFileQJViewController alloc]init];
    [filess returnRoomName:^(NSDictionary *roomName) {
        fileUrl = roomName;
        WenName = [fileUrl objectForKey:@"WenMingzi"];
        WenPath = [fileUrl objectForKey:@"WenPath"];
        NSLog(@"文件%@",fileUrl);
        
    }];
    filess.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:filess animated:NO];
    
}
#pragma mark 提交数据
- (void)tijiaoHeTong{
    
    if ([Utile stringIsNil:typeStr]) {
        [self showHint:@"请选择案件类型"];
        return;
    }
    if ([Utile stringIsNil:party_information]) {
        [self showHint:@"请选择当事人信息"];
        return;
    }
    if ([Utile stringIsNil:PriceStr]) {
        [self showHint:@"请填写报价"];
        return;
    }
    if ([Utile stringIsNil:timeStr]) {
        [self showHint:@"请选择交付时间"];
        return;
    }
    if ([Utile stringIsNil:middleshowview.PltextVeiw.text]) {
        [self showHint:@"请填写合同描述"];
        return;
    }

 
  
    if (fileUrl == nil) {
        [self showHint:@"请选择需要上传的文档"];
        return;
  
    }
    
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultcheckContact
    NSDictionary * valudic;
    valudic  = @{@"user_id":UserId,@"contract_description":middleshowview.PltextVeiw.text,@"contract_type":typeStr,@"party_information":party_information ,@"offer":PriceStr,@"time":timeStr};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    //发送post请求上传路径
    /*
     第一个参数:请求路径
     第二个参数:字典(非文件参数)
     第三个参数:constructingBodyWithBlock 处理要上传的文件数据
     第四个参数:进度回调
     第五个参数:成功回调 responseObject响应体信息
     第六个参数:失败回调
     */
    [self showHudInView:self.view hint:nil];
    [manager POST:MainUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        //使用formData拼接数据
        /* 方法一:
         第一个参数:二进制数据 要上传的文件参数
         第二个参数:服务器规定的
         第三个参数:文件上传到服务器以什么名称保存
         */
//        WenPath
        NSData  * data =[NSData dataWithContentsOfFile:WenPath];

        [formData appendPartWithFileData:data name:@"file" fileName:WenName mimeType:@"application/octet-stream"];
        //
        //方法二:
        //      [formData appendPartWithFileURL:[NSURL fileURLWithPath:WenPath] name:@"file" fileName:WenName mimeType:@"text/plain" error:nil];
        
        //方法三:
        // [formData appendPartWithFileURL:[NSURL fileURLWithPath:@""] name:@"file" error:nil];
        
    }
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
             NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
             
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"上传成功%@",responseObject);
              NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
              if ([status isEqualToString:@"0"]) {
                  
                  middleshowview.PltextVeiw.text  = @"";
                  typeStr = @"";
                  Topleshowview.AreaLb.text = @"请选择案件领域";
                  typeStr = @"";
                  fileUrl =nil;
                  Topleshowview.PerInfoLB.text= @"请选择当事人信息";
                  party_information =@"";
                  timeStr =@"";
                  Topleshowview.TimeLb.text = [NSString stringWithFormat:@"请选择交付时间"];
                  Topleshowview.PriceTextField.text=@"";
                  PriceStr =@"";
                  
                  middleshowview.TypeLb.text = @"请选择合同类型";
                   [_TV reloadData];
                  
                  QJPayViewController * pavVc =[[QJPayViewController alloc]init];
                  pavVc.title = @"法律服务支付";
                  pavVc.payType = @"2";
                  
                  pavVc.payID = responseObject[@"data"];
                  pavVc.BuyConcent = @"3";
                  pavVc.payName= [NSString stringWithFormat:@"%@服务费",self.title];
                  pavVc.payPrice= moneyStr;
                  pavVc.hidesBottomBarWhenPushed =YES;
                  [self.navigationController pushViewController:pavVc animated:YES];
                  
                  
              }
              else{
                  [self showHint:responseObject[@"msg"]];
              }
              [self hideHud];
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [self showHint:@"上传失败，请重试"];
              [self hideHud];
              NSLog(@"上传失败.%@",error);
          }];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    PriceStr  = textField.text;
    return  YES;
}

#pragma mark  选择时间
- (void)diChoseTime{
    [self didTimeButton];
 }

#pragma mark 随访时间 start time
- (void)didTimeButton{
    if(selectPick==nil){
        _backWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight)];
        _backWindowView.backgroundColor = [UIColor blackColor];
        _backWindowView.alpha = 0.5;
        
        
        [self.view addSubview:_backWindowView];
        selectPick = [DatePickerView datePickerView];
        selectPick.delegate = self;
        selectPick.type = 0;
        selectPick.frame= CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
        [self.view addSubview:selectPick];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            selectPick.frame = CGRectMake(0, ConentViewHeight-184, ConentViewWidth, 184);
        } completion:^(BOOL finished) {
        }];
        
    }else{
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_backWindowView removeFromSuperview];
            _backWindowView = nil;
            selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
        } completion:^(BOOL finished) {
            [selectPick removeFromSuperview];
            selectPick = nil;
        }];
    }
    
    
    
}
- (void)getcancel{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_backWindowView removeFromSuperview];
        _backWindowView = nil;
        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
    } completion:^(BOOL finished) {
        [selectPick removeFromSuperview];
        selectPick = nil;
    }];
    
}
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    timeStr = [NSString stringWithFormat:@"%@", date];
    Topleshowview.TimeLb.text = [NSString stringWithFormat:@"%@", timeStr];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_backWindowView removeFromSuperview];
        _backWindowView = nil;
        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
    } completion:^(BOOL finished) {
        [selectPick removeFromSuperview];
        selectPick = nil;
    }];
    [_TV reloadData];
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
