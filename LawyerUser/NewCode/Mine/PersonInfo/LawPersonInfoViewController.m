//
//  LawPersonInfoViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPersonInfoViewController.h"
#import "LawInfoCell.h"
#import "LawInforImageCell.h"
#import "LawPlatformAuthViewController.h"
#import "LawBankCardViewController.h"
#import  "lawCompanyImageVC.h"
#import "LawChagebasicInfoVC.h"
#import "LawChangeSexViewController.h"
#import "LawSeletAreaViewController.h"
#import "LawJCImageSelect.h"
#import "LawPlatformModel.h"
@interface LawPersonInfoViewController ()<selectImagedelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSArray * titleArray;
    NSArray * contentArray;
    LawPlatformModel * platforModel;
    
  }


@end

@implementation LawPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"个人信息" titleColor:nil];
    titleArray = @[@"头像",@"昵称",@"性别",@"联系电话",@"地区"];
      self.view.backgroundColor  =   BackViewColor;
    
     [self addView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self makePersonInfo];
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight+1  , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  -1) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.backgroundColor = BackViewColor;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.tableFooterView = [[UIView alloc]init];
  
     [self.view addSubview:_tableView];
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if(section==0){
         return  titleArray.count;
     }else{
         return 2;
     }
     
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.01;
    }else{
        return 10;
    }
 
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc]init];
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        headerView.backgroundColor = BackViewColor;
        return headerView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
        LawInforImageCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInforImageCell" owner:self options:nil]lastObject];
        }
            cell.CellTitile.text = @"头像";
            if (self.infoModel.avatar) {
                [cell.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,self.infoModel.avatar]] placeholderImage:nil];
            }
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        }
        else{
            LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];

            if (cell == nil) {
                cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
            }
            
            cell.RightImg.hidden  =  NO ;

            cell.TypeLB.text =[NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
//            cell.ConcentLB.text =[NSString stringWithFormat:@"%@",contentArray[indexPath.row]];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.LineView.hidden = NO;
            if (indexPath.row == titleArray.count -1) {
                cell.LineView.hidden = YES;

            }
            if (indexPath.row == 1) {
                cell.ConcentLB.text = self.infoModel.name?self.infoModel.name:@"昵称";
            }else if (indexPath.row ==2){
            cell.ConcentLB.text = [self.infoModel.sex isEqualToString:@"1"]?@"男":@"女";
            }else if (indexPath.row ==3){
                cell.ConcentLB.text = self.infoModel.phone?self.infoModel.phone:@"";
                cell.RightImg.hidden = YES;
//                cell.accessoryType = UITableViewCellAccessoryNone;
             }else if (indexPath.row ==4){
                 
                 cell.ConcentLB.text = self.infoModel.city_name?[NSString stringWithFormat:@"%@ %@ %@",self.infoModel.province_name,self.infoModel.city_name,self.infoModel.area_name]:@"";

             }
            
            return  cell ;
        }
    }else if(indexPath.section == 1){
      
        
        if(indexPath.row ==0){
            LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
            }
            cell.TypeLB.text =[NSString stringWithFormat:@"企业名称"];
            cell.ConcentLB.text =self.infoModel.company_name?self.infoModel.company_name:@"未填写";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.RedView.hidden = YES;
            return  cell ;

        }else
        {
            
            LawInforImageCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
            if (cell == nil) {
                cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInforImageCell" owner:self options:nil]lastObject];
            }
            cell.CellTitile.text = @"企业营业执照";
            if (self.infoModel.license) {
                [cell.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,self.infoModel.license]] placeholderImage:nil];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
         
             return  cell ;
 
        }
 
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (indexPath.row == 0) {
            
          
            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
            
            changeName.titleStr =@"企业名称";
            changeName.placherStr= self.infoModel.company_name?self.infoModel.company_name:@"请输入您的企业名称";
            
            changeName.ChangValue = ^(NSString *changeValueStr) {
                [self   ChangInformationWithDic:@{@"company_name":changeValueStr} ];
                
            };
            [self.navigationController pushViewController:changeName animated:YES];
            
            
            
//            LawPlatformAuthViewController * law =[[LawPlatformAuthViewController alloc]init];
//            law.model = platforModel;
//                  law.CanEidt  = YES ;
//
//            [self.navigationController pushViewController:law animated:YES];
        }else if (indexPath.row == 1){
            lawCompanyImageVC * law =[[lawCompanyImageVC alloc]init];
//                        law.model = platforModel;
 
                        [self.navigationController pushViewController:law animated:YES];
        
        }
    }else{
        if(indexPath.row == 0){
            LawJCImageSelect * selectImage =[LawJCImageSelect defaultSelectImage];
            selectImage.delegate = self;
         [ selectImage showInViewController:self];
        }
      else  if ( indexPath.row == 1){
//            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
         
          LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
 
          changeName.titleStr =@"修改昵称";
            changeName.placherStr= self.infoModel.name?self.infoModel.name:@"请输入您的名字";
          
          changeName.ChangValue = ^(NSString *changeValueStr) {
                 [self   ChangInformationWithDic:@{@"name":changeValueStr} ];

             };
            [self.navigationController pushViewController:changeName animated:YES];
        }else if(indexPath.row == 2){
            LawChangeSexViewController * lawSex =[[LawChangeSexViewController alloc]init];
            //           判断显示
            lawSex.sex = self.infoModel.sex;
            lawSex.SexBlock = ^(NSString *sexStr) {
                [self   ChangInformationWithDic:@{@"sex":sexStr} ];
            };
            [self.navigationController pushViewController:lawSex animated:YES];
            
        } else if(indexPath.row == 4 ){
            LawSeletAreaViewController * area =[[LawSeletAreaViewController alloc]init];
           
            area.ProviStr =self.infoModel.province_name;
            area.CityStr =self.infoModel.city_name;
            area.AreaStr =self.infoModel.area_name;
 
            
            
            area.SelectAreaBlock = ^(NSString *Proid, NSString *Cityid, NSString *Areamid, NSString *areaStr) {
                [self   ChangInformationWithDic:@{@"province":Proid,@"city":Cityid,@"area":Areamid} ];

            };
            [self.navigationController pushViewController:area animated:nil];
        }else if (indexPath.row == 5){
            LawBankCardViewController * card =[[LawBankCardViewController alloc]init];
            [self.navigationController pushViewController:card animated:YES];
            
        }
        
    }
    
    
//    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.section == 0 && indexPath.row == 0)|| (indexPath.section == 1 && indexPath.row == 1)){
         return 100;
    }else{
         return 60;
    }
}

#pragma mark  选择图片的代理
-(void)seleWithImage:(UIImage *)selectImage{
    
    NSData   * imageData  = UIImageJPEGRepresentation(selectImage, 0.01);
     NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];

    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    [dic setValue:base64String forKey:@"value"];
    NewAddInfo
    [AFManagerHelp   asyncUploadFileWithData:imageData name:@"avatar" fileName:@"PersonHeadPic.jpg" mimeType:@"image/jpeg" parameters:dic success:^(id responseObject) {

        if ([responseObject[@"status"] integerValue] == 0) {


        }else{
            [ShowHUD showWYBTextOnly:responseObject[@"msg"] duration:2 inView:self.view];
        }

        [self hideHud];
    } failture:^(NSError *error) {
        [self hideHud];

    }];

    
}
-(void)cancelSelecImage{
    
    
}
// 更改基本信息
-(void)ChangInformationWithDic:(NSDictionary *)dicc{
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]initWithDictionary:dicc];
    [valuedic setValue:UserId forKey:@"uid"];
    NewAddInfo
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
//    NewAddInfor ;
    [dic setValue:base64String forKey:@"value"];
    MJWeakSelf;
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        if ([responseObjeck[@"status"] integerValue] == 0) {
           

        }else{
           [self showHint:responseObjeck[@"msg"]];
        }
        
        [self hideHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self hideHud];
    }];

    
}

-(void)makePersonInfo{
 

//action、value
    NSDictionary *valuedic ;
         valuedic  = @{  @"uid":UserId};
 
NSString * base64String =[NSString getBase64StringWithArray:valuedic];

NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
NewGetInfor ;
[dic setValue:base64String forKey:@"value"];
MJWeakSelf;
[AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
    // 处理数据
    DLog(@" %@",responseObjeck);
     if ([responseObjeck[@"status"] integerValue] == 0) {
        weakSelf.infoModel = [MyInfoModel mj_objectWithKeyValues:responseObjeck[@"data"]];
        platforModel = [LawPlatformModel yy_modelWithJSON:responseObjeck[@"data"][@"renzhengInfo"]];
             
 
        [_tableView reloadData];
    }else{
        [self showHint:responseObjeck[@"msg"]];
    }
    
} failure:^(NSError *error) {
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
