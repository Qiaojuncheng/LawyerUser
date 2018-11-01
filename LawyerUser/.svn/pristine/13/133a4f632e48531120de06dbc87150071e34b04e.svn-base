//
//  QJConsultViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJConsultViewController.h"
#import "UIViewAdditions.h"
#import "QJConsultCell.h"
#import "QJZIXunModel.h"
@interface QJConsultViewController (){
    NSInteger Page;
}

@end

@implementation QJConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self makeBackItem];
    DataArray = [NSMutableArray array];

    Page = 1;
    [self makeData];
    [self makeui];
    // Do any additional setup after loading the view.
}

-(void)makeData{
         NSDictionary * dic  =[[NSMutableDictionary alloc]init];
        QJZIXUNLIST
        NSDictionary * valueDic  = @{@"user_id":UserId,@"p":[NSString stringWithFormat:@"%ld",Page]};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
        [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
        [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
            NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
            if ([str isEqualToString:@"0"]) {
                if (Page ==1) {
                    [DataArray removeAllObjects];
                }
                for (NSDictionary * dic in data[@"data"]) {
                    QJZIXunModel * model = [QJZIXunModel yy_modelWithDictionary:dic];
                    [model makeHeight];
                    [DataArray addObject:model];
                }
            }else{
                NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
                [self showHint:msg];
            }
            [self hideHud];
            [_tv reloadData];

            [_tv.mj_footer endRefreshing];
            [_tv.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [self hideHud];
            [_tv.mj_footer endRefreshing];
            [_tv.mj_header endRefreshing];
            NSLog(@"%@",error);
        }];
 
}

-(void)makeui{
    
     _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - NavStatusBarHeight -40) style:UITableViewStylePlain];
    _tv.tableFooterView =[[UIView alloc]init];
    _tv.delegate= self;
    _tv.dataSource = self;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tv.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        Page ++;
        [self makeData];
    }];
    _tv.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Page =1;
        [self makeData];
    }];

     [self.view addSubview:_tv];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    QJConsultCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJConsultCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QJZIXunModel * modle =DataArray[indexPath.row];
    cell.model = modle;
     return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QJZIXunModel * modle =DataArray[indexPath.row];
     return modle.Height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"进入详情了 ");
    
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
