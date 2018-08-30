//
//  QJMyGuanZhuViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/26.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMyGuanZhuViewController.h"
#import "QJNeedReplyTableViewCell.h"
#import "QJGuanZhuModel.h"
#import "QJlawyerDetailsViewController.h"
@interface QJMyGuanZhuViewController (){
    BOOL isEnding;
}
@property (nonatomic,strong)UIButton *issueButton;
@end

@implementation QJMyGuanZhuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   // [self makeBackItem];
    DataArray  =[[NSMutableArray alloc]init];

    self.title = @"我的关注";
    isEnding = NO;
    
    self.issueButton = [[UIButton alloc]init];
    self.issueButton.frame = CGRectMake(0, 0, 54, 30);
    self.issueButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [self.issueButton setTitle:@"编辑" forState:normal];
    [self.issueButton setTitle:@"取消" forState:UIControlStateSelected];
    _issueButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_issueButton setTitleColor:[UIColor whiteColor] forState:normal];
    [_issueButton addTarget:self action:@selector(onClickedView:) forControlEvents:UIControlEventTouchUpInside];
    //添加到导航条
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:_issueButton];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;

    
    [self maekData];
    
    [self makeUI];
    // Do any additional setup after loading the view.
}
- (void)onClickedView:(UIButton *)sender{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        isEnding = YES;
    }else{
        isEnding = NO;
    }
    
    [_tv reloadData];
}
-(void)maekData{
    NSMutableDictionary * valueDic =[[NSMutableDictionary alloc]init];
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    MYGUANZHU
    [valueDic setValue:UserId forKey:@"uid"];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
     [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            for (NSDictionary * dic in data[@"data"]) {
                QJGuanZhuModel * mode =[QJGuanZhuModel yy_modelWithDictionary:dic];
                [DataArray addObject:mode];
             }
            
            
            
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
         
         [_tv reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(void)makeUI{
    
    
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.delegate=self;
    _tv.dataSource =self;
    _tv.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_tv];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QJNeedReplyTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJNeedReplyTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    QJGuanZhuModel *model = DataArray[indexPath.row];
    UIButton *btns = [[UIButton alloc]init];
    btns.layer.masksToBounds = YES;
    btns.layer.cornerRadius = 8;
    btns.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
    btns.titleLabel.font = [UIFont systemFontOfSize:16];
    btns.layer.borderColor =borderColorRef;

    [cell.contentView addSubview:btns];
    if (isEnding) {
        btns.frame = CGRectMake(ConentViewWidth - 80, 8, 70, 28);
        [btns setTitle:@"取消关注" forState:normal];
        [btns setTitleColor:MAINCOLOR forState:normal];
        btns.backgroundColor = [UIColor whiteColor];
    }else{
        [btns setTitle:@"详情" forState:normal];
        btns.frame = CGRectMake(ConentViewWidth - 60,8, 50, 28);
        [btns setTitleColor:[UIColor whiteColor] forState:normal];
        btns.backgroundColor = MAINCOLOR;
        
    }
    btns.tag = indexPath.row;
    [btns addTarget:self action:@selector(didCancelGuanzhu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.model = model;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QJGuanZhuModel * model =  DataArray[indexPath.row];
    QJlawyerDetailsViewController *lae  = [[QJlawyerDetailsViewController alloc]init];
    lae.lawyerID = [NSString stringWithFormat:@"%@",model.lid];
    lae.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lae animated:NO];


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 100;
}

- (void)didCancelGuanzhu:(UIButton *)sender{
    if (isEnding) {
        QJGuanZhuModel *model = DataArray[sender.tag];
        [self makeCancel:model.id];
    }else{
        
    }
    
    
}
- (void)makeCancel:(NSString *)stringId{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Userqxguanzhu
    NSDictionary * valudic  = @{@"id":stringId};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"取消关注%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            [DataArray removeAllObjects];
            [self maekData];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"添加关注失败，请稍后重试！"];
        NSLog(@"取消关注%@",error);
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
