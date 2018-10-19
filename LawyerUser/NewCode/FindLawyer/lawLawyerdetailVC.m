//
//  lawLawyerdetailVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawLawyerdetailVC.h"
#import "lawLawyerDetailModle.h"
#import "lawDetailTopCell.h"
#import "lawDetailMiddleCell.h"
#import "lawdetailBottomCell.h"
#import "lawAppointmentVC.h"
#import "lawFindSendHeaderVC.h"
@interface lawLawyerdetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView * _tableView ;
    UIButton  * bottomBtn ;
     NSString * payType;
    BOOL ShowAll;// YES 简介显示完 NO简介显示不完
    CGFloat Allheight;
}
@property (strong ,nonatomic )lawLawyerDetailModle * model;
@end

@implementation lawLawyerdetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowAll  = NO ;
    [self addCenterLabelWithTitle:@"律师详情" titleColor:nil];
    [self makedata];
    [self addView];
    // Do any additional setup after loading the view from its nib.
}
-(void)makedata{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    LawMaingetlawyerXq
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    if(IsLogin){
        
        [valueDic setObject:[NSString stringWithFormat:@"%@",UserId ] forKey:@"uid" ];

    }
    [valueDic setObject:self.lawyerid forKey:@"lid" ];
   
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
         [self showHudInView:self.view hint:nil];
     [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
      
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            
                 self.model =  [lawLawyerDetailModle yy_modelWithDictionary:data[@"data"]];
 
            Allheight = [NSString GetHeightWithMaxSize:CGSizeMake(SCREENWIDTH - 33 , MAXFLOAT) AndFont:[UIFont systemFontOfSize:15] AndText:self.model.instru].height;
            
            [_tableView reloadData];
        }
        [self hideHud];
     } failure:^(NSError *error) {
        [self hideHud];
        
    }];
    
}
-(void)addView{
    self.view.backgroundColor = [UIColor colorWithHex:0xf7f7f7];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight - 55 ) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
   
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
 
    [self.view addSubview:_tableView];
    [self makeBottomView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model?3:0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        lawDetailTopCell * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell  =[[[NSBundle mainBundle]loadNibNamed:@"lawDetailTopCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return  cell;
    }else if (indexPath.row == 1) {
        lawDetailMiddleCell * cell  =[tableView dequeueReusableCellWithIdentifier:@"middlecell"];
        if (!cell) {
            cell  =[[[NSBundle mainBundle]loadNibNamed:@"lawDetailMiddleCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reloadDateBlock = ^{
            ShowAll = !ShowAll;
            [tableView reloadData];
        };
        cell.model = self.model;
        cell.show = ShowAll;
        return  cell;

    }else if (indexPath.row == 2) {
        lawdetailBottomCell * cell  =[tableView dequeueReusableCellWithIdentifier:@"bottomcell"];
        if (!cell) {
            cell  =[[[NSBundle mainBundle]loadNibNamed:@"lawdetailBottomCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.touchBlock = ^(NSInteger index) {
            if (index == 10) {
                bottomBtn.backgroundColor = MAINCOLOR;
                bottomBtn.userInteractionEnabled = YES ;

                payType = @"电话";
            }else if (index ==11){
                bottomBtn.backgroundColor = MAINCOLOR;
                bottomBtn.userInteractionEnabled = YES ;

                payType = @"预约";
            }else{
//              直接是送心意
                
                lawFindSendHeaderVC * sendHeader = [[lawFindSendHeaderVC alloc]init];
                sendHeader.model = self.model;
                [self.navigationController pushViewController:sendHeader animated:YES];
            }
                
            
        };
        cell.model = self.model;
        return  cell;
    }
    return  [[UITableViewCell alloc]init] ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    LawSquarSrviceViewDetailController * detail =[[LawSquarSrviceViewDetailController alloc]init];
    //    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return  170;
    }else if (indexPath.row == 1){
        
            return ShowAll?Allheight + 118:192 ;
    }else{
         return 110 ;
    }
    
}
-(void)makeBottomView{
    bottomBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame =  CGRectMake(0, SCREENHEIGHT  - 55, SCREENWIDTH, 55);
    bottomBtn.backgroundColor = [UIColor colorWithHex:0xE5E5E5];
    [bottomBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor colorWithHex:0xffffff]  forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(SureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomBtn];
    bottomBtn.userInteractionEnabled = NO  ;

}
-(void)SureAction:(UIButton *)sender{
   
    NSLog(@"类型 --%@",payType);
    lawAppointmentVC * appointment = [[lawAppointmentVC alloc]init];
    if ([payType isEqualToString:@"电话"]) {
        appointment.IsPhoneMeeting = YES ;
    }else{
        appointment.IsPhoneMeeting = NO  ;
    }
    [self.navigationController pushViewController:appointment animated:YES];
    
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
