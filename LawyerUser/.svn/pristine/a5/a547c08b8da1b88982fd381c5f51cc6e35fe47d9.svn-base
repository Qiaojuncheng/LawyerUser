//
//  WYWenShuViewController.m
//  Lawyer
//
//  Created by yu on 2017/9/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYWenShuViewController.h"
#import "QJSelectItemView.h"
@interface WYWenShuViewController (){
    NSMutableArray *listArray;
    NSMutableArray *nameArr;
    UIWebView *webview;
}

@end

@implementation WYWenShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合同模板";
    self.view.backgroundColor = [UIColor whiteColor];
    
    listArray = [NSMutableArray array];
    nameArr = [NSMutableArray array];
    
    [self makeData];
    // Do any additional setup after loading the view.
}
#pragma mark    文书规范信息
- (void)makeData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Consultarticle
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"文书规范信息%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [listArray addObjectsFromArray:data[@"data"]];
            for (NSDictionary *dica in data[@"data"]) {
                [nameArr addObject:[dica objectForKey:@"title"]];
            }
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self makeDataview];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"文书规范信息%@",error);
    }];

}
- (void)makeDataview{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, ConentViewWidth, 44)];
    [self.view addSubview:topView];
    
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    titLab.font = [UIFont systemFontOfSize:16];
    titLab.text = [NSString stringWithFormat:@"合同模板"];
    [topView addSubview:titLab];
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titLab.frame)+ 10, 0, ConentViewWidth - 110 - 50, 44)];
    detailLab.font = [UIFont systemFontOfSize:14];
    detailLab.textAlignment = NSTextAlignmentRight;
    
    [topView addSubview:detailLab];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth - 30, 13,12, 18)];
    img.image = [UIImage imageNamed:@"l-right"];
    [topView addSubview:img];
    
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), ConentViewWidth, ConentViewHeight - CGRectGetMaxY(topView.frame))];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]]]];
    [self.view addSubview:webview];
    
    detailLab.text = @"请选择合同模板";
    [detailLab whenTouchedUp:^{
       
        QJSelectItemView *seleView=  [[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt = @"合同模板";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:nameArr];
        seleView.selectWithIndexBlcik = ^(int index){
            detailLab.text = [NSString stringWithFormat:@"%@",nameArr[index]];
           
            NSString *strings = [NSString stringWithFormat:@"%@",listArray[index][@"content"]];
            [webview loadHTMLString:strings baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@notice/detail.json",MainUrl]]];
        };
        [self.view addSubview:seleView];
        [seleView showView];
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
