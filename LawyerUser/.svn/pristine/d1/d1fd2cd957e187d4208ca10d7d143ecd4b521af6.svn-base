//
//  QJlawyerDetailsViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/16.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJlawyerDetailsViewController.h"
#import "QJLawyerTItleCell.h"
#import "QJLawyerInfoCell.h"
#import "QJtextlableCell.h"
#import "QJServiceCell.h"

#import "WYlawyerDetail.h"

#import "QJPhoneServiceViewController.h"
#import "QJFindappointViewController.h"
#import "WYzixunViewController.h"



@interface QJlawyerDetailsViewController (){

    NSArray * headerViewArray ;
    NSArray * BaseLabelArray ;
    NSDictionary *detailInfodic;
    CGRect rectOne;
    CGRect rectTwo;
    CGRect rectThree;
    NSString *guanzhuStr;
    NSArray *anliArr;
}

@end

@implementation QJlawyerDetailsViewController{
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self makeBackItem];
    self.title  = @"律师详情";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedView)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self makeUI];
    [self makelawxqData];
    
    // Do any additional setup after loading the view.
}
- (void)onClickedView{
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = @"http://mobile.umeng.com/social";
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
        
        
    }];
    
}

#pragma mark 律师详情
- (void)makelawxqData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Userlawxq
    NSDictionary * valudic  = @{@"lid":self.lawyerID,@"uid":UserId};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"律师详情%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            detailInfodic = [NSDictionary dictionaryWithDictionary:data[@"data"]];
            guanzhuStr = [NSString stringWithFormat:@"%@",[detailInfodic objectForKey:@"lawyerKeep"]];
            
            anliArr = [NSArray arrayWithArray:data[@"data"][@"cate"]];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        
        [_tv reloadData];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"登录失败，请稍后重试！"];
        NSLog(@"律师详情%@",error);
    }];

}
-(void)makeUI{

    DataArray =[[NSMutableArray alloc]init];
    
    BaseLabelArray  =[[NSArray alloc]initWithObjects:@"证件号",@"从业机构",@"性别",@"电子邮箱", nil];
    
//    headerViewArray =[[NSArray alloc]initWithObjects:@"头像",@"基本信息",@"律师简介",@"社会职务",@"成功案例",@"律师服务" ,nil];
    headerViewArray =[[NSArray alloc]initWithObjects:@"头像",@"基本信息",@"律师简介",@"律师服务" ,nil];

    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStyleGrouped];
    _tv.delegate = self;
    _tv.dataSource  = self;
    
    [self.view addSubview:_tv];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return  headerViewArray.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section  == 0 || section == 2 ) {
        return 1;
    }else if (section  == 1){
        return 4;
    }
//        else if (section == 4){
//        if (anliArr.count == 0) {
//            return 1;
//        }else{
//            return anliArr.count;
//        }
//
//    }
    else {
        return  2;
    
    }
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section  == 0 ) {
        return 106;
    }else if (indexPath.section  == 1){
        return 44;
    }else if (indexPath.section  == 2){
        return rectOne.size.height + 20;
    }
//    else if (indexPath.section  == 3){
//        return rectTwo.size.height + 20;
//    }else if (indexPath.section == 4){
//        if (anliArr.count == 0) {
//            return rectThree.size.height + 20;
//        }else{
//            return rectThree.size.height + 20;
//        }
//    }
    else{
        return  60;
        
    }
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 0.01;
    }else{
        return 10;
    }
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYlawyerDetail *model = [WYlawyerDetail yy_modelWithDictionary:detailInfodic];
    if (indexPath.section == 0) {
        QJLawyerTItleCell * titeCell =[[[NSBundle mainBundle]loadNibNamed:@"QJLawyerTItleCell" owner:self options:nil]lastObject];
        titeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        titeCell.model = model;
        
        [titeCell.guanzhuBtn addTarget:self action:@selector(addGuanZhu) forControlEvents:UIControlEventTouchUpInside];
        
        return titeCell;
    }else if (indexPath.section ==1){
    
        QJLawyerInfoCell * titeCell =[[[NSBundle mainBundle]loadNibNamed:@"QJLawyerInfoCell" owner:self options:nil]lastObject];
        titeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        titeCell.BaseNameLB.text   = [NSString stringWithFormat:@"%@",BaseLabelArray[indexPath.row]];
        titeCell.BaseIcon.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",BaseLabelArray[indexPath.row]]];
        NSString *sexStr = [NSString stringWithFormat:@"%@",model.sex];
        NSArray *infoarr;
        if ([sexStr isEqualToString:@"1"]) {
            infoarr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",model.lawyer_code],[NSString stringWithFormat:@"%@",model.authority],@"男",[NSString stringWithFormat:@"%@",model.email], nil];
        }else{
            infoarr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",model.lawyer_code],[NSString stringWithFormat:@"%@",model.authority],@"女",[NSString stringWithFormat:@"%@",model.email], nil];
        }
        titeCell.BaseNumber.text = infoarr[indexPath.row];
        titeCell.BaseNumber.text = [titeCell.BaseNumber.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"暂无"];
        
        return titeCell;
    
//    }else if ((indexPath.section ==2 )||(indexPath.section  == 3)||(indexPath.section == 4)){
    }else if (indexPath.section ==2 ){

        static NSString *cellIdter = @"cellId";
        QJtextlableCell *cellTwo = [tableView dequeueReusableCellWithIdentifier:cellIdter];
        if (!cellTwo) {
            cellTwo = [[[NSBundle mainBundle]loadNibNamed:@"QJtextlableCell" owner:self options:nil] lastObject];
            cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section == 2) {
            cellTwo.ConcentLabel.frame = CGRectMake(10, 10, ConentViewWidth - 20, 0);
        
            if ([Utile stringIsNil:model.instru]) {
                cellTwo.ConcentLabel.text =[NSString stringWithFormat:@"还没有填写律师简介"];
            }else{
                cellTwo.ConcentLabel.text =[NSString stringWithFormat:@"%@",model.instru];
            }
            
            rectOne = [cellTwo.ConcentLabel boundingRectWithInitSize:cellTwo.ConcentLabel.frame.size];
            cellTwo.ConcentLabel.frame = CGRectMake(10, 10, ConentViewWidth - 20, rectOne.size.height);
            
        }
//        else if(indexPath.section == 3){
//            cellTwo.ConcentLabel.frame = CGRectMake(10, 10, ConentViewWidth - 20, 0);
//            if ([Utile stringIsNil:model.important]) {
//                cellTwo.ConcentLabel.text =[NSString stringWithFormat:@"还没有填写社会职务"];
//            }else{
//                cellTwo.ConcentLabel.text =[NSString stringWithFormat:@"%@",model.important];
//            }
//
//            rectTwo = [cellTwo.ConcentLabel boundingRectWithInitSize:cellTwo.ConcentLabel.frame.size];
//            cellTwo.ConcentLabel.frame = CGRectMake(10, 10, ConentViewWidth - 20, rectTwo.size.height);
//        }else{
//
//
//
//            if (model.cate.count == 0) {
//
//                cellTwo.ConcentLabel.frame = CGRectMake(10, 10, ConentViewWidth - 20, 0);
//                cellTwo.ConcentLabel.text =[NSString stringWithFormat:@"还没有填写成功案例"];
//                rectThree = [cellTwo.ConcentLabel boundingRectWithInitSize:cellTwo.ConcentLabel.frame.size];
//                cellTwo.ConcentLabel.frame = CGRectMake(10, 10, ConentViewWidth - 20, rectThree.size.height);
//            }else{
//
//                cellTwo.ConcentLabel.frame = CGRectMake(20, 10, ConentViewWidth - 30, 0);
//                cellTwo.ConcentLabel.text =[NSString stringWithFormat:@"%@",anliArr[indexPath.row][@"instru"]];
//                rectThree = [cellTwo.ConcentLabel boundingRectWithInitSize:cellTwo.ConcentLabel.frame.size];
//                cellTwo.ConcentLabel.frame = CGRectMake(20, 10, ConentViewWidth - 30, rectThree.size.height);
//                UIImageView *imageinf = [[UIImageView alloc]initWithFrame:CGRectMake(8, rectThree.size.height/2, 6, 6)];
//                imageinf.backgroundColor = MAINCOLOR;
//                imageinf.layer.masksToBounds = YES;
//                imageinf.layer.cornerRadius = 3;
//                [cellTwo.contentView addSubview:imageinf];
//
//            }
//
//
//
//
//
//        }
        return cellTwo;
    }else{
        QJServiceCell * titeCell =[[[NSBundle mainBundle]loadNibNamed:@"QJServiceCell" owner:self options:nil]lastObject];
        titeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row ==0) {
            titeCell.Iconimg.image =[UIImage imageNamed:@"预约面谈"];
            titeCell.TitleLB.text=@"电话咨询";
            titeCell.PriceLB.text =[NSString stringWithFormat:@"%@/次",detailInfodic[@"phone_price"]];
            titeCell.SubLB.text=@"与律师进行电话咨询";
        }else{
            titeCell.Iconimg.image =[UIImage imageNamed:@"电话咨询"];
            titeCell.TitleLB.text=@"预约面谈";
            titeCell.PriceLB.text =[NSString stringWithFormat:@"%@/次",detailInfodic[@"meet_price"]];

            titeCell.SubLB.text =@"与律师面对面交流";
        }
        return titeCell;
    
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return  30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return  [[UIView alloc]init];
    }
    UIView * HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, ConentViewHeight)];
    
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 2.5, ConentViewWidth -10, 25)];
    titleLabel.text  = [NSString changeNullString:[NSString stringWithFormat:@"%@",headerViewArray[section]]];
    titleLabel.textColor =[UIColor colorWithRed:101/245.0 green:102/245.0 blue:103/245.0 alpha:1];
    titleLabel.backgroundColor =[UIColor whiteColor];
    [HeaderView addSubview:titleLabel];
    HeaderView.backgroundColor =[UIColor colorWithRed:244/245.0 green:245/245.0 blue:246/245.0 alpha:1];
    
    return HeaderView;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            WYzixunViewController * pvc =[[WYzixunViewController alloc]init];
            pvc.lvshiId = [NSString stringWithFormat:@"%@",[detailInfodic objectForKey:@"id"]];
            pvc.title = @"电话预约";
            pvc.yuyuePrice =detailInfodic[@"phone_price"];
            pvc.typeStr = [NSString stringWithFormat:@"1"];
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pvc  animated:YES];
        }else if (indexPath.row ==1){
            
            WYzixunViewController * pvc =[[WYzixunViewController alloc]init];
            pvc.lvshiId = [NSString stringWithFormat:@"%@",[detailInfodic objectForKey:@"id"]];
            pvc.addressStr = [NSString stringWithFormat:@"%@%@%@%@",[detailInfodic objectForKey:@"province_name"],[detailInfodic objectForKey:@"city_name"],[detailInfodic objectForKey:@"area_name"],[detailInfodic objectForKey:@"address"]];
            pvc.title = @"面谈预约";
            pvc.yuyuePrice =detailInfodic[@"meet_price"];

            pvc.typeStr = [NSString stringWithFormat:@"2"];
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pvc  animated:YES];
        }

    }

}

#pragma mark 添加关注
- (void)addGuanZhu{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UsercancelAttention
    NSDictionary * valudic  = @{@"lawyer_id":[detailInfodic objectForKey:@"id"],@"user_id":UserId};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"添加关注%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            
            [self makelawxqData];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"添加关注失败，请稍后重试！"];
        NSLog(@"添加关注%@",error);
    }];

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
