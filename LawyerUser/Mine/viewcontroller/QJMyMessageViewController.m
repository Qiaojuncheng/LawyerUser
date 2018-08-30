//
//  QJMyMessageViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMyMessageViewController.h"
#import "QJMyMesssageCell.h"
@interface QJMyMessageViewController ()

@end

@implementation QJMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creataData];
    // Do any additional setup after loading the view.
}
-(void)creataData{

    dataArray =[[NSArray alloc]initWithObjects:@"first",@"ds",@"sd",nil];
    [self creatView];
}
-(void)creatView{
  self.title = @"消息";
    //[self makeBackItem];

    
    UIButton * RightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    RightBtn.frame = CGRectMake(0 , 0, 40, 40);
    [RightBtn setTitle:@"清空" forState:UIControlStateNormal];
    [RightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [RightBtn addTarget:self action:@selector(RightBtnClearAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * RightItem =[[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    
    self.navigationItem.rightBarButtonItem= RightItem;
    
    
    TV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
//    TV.backgroundColor= [UIColor redColor];
    TV.dataSource= self;
    TV.delegate= self;
    
    TV.tableFooterView= [[UIView alloc]init];

    [self.view addSubview:TV];

}

-(void)RightBtnClearAction{

    NSLog(@"清空");

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJMyMesssageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"QJMyMesssageCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSLog(@"%ld行",indexPath.row);

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;

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
