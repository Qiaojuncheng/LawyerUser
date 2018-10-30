//
//  QJHistoryViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJHistoryViewController.h"
#import "SMPagerTabView.h"
#import "UIViewAdditions.h"
#import "QJEspenseViewController.h"
#import "QJConsultViewController.h"

@interface QJHistoryViewController ()

@property (nonatomic, strong) NSMutableArray * allVcArray; // 存放界面
@property (nonatomic, strong) SMPagerTabView *segmentView;

@end

@implementation QJHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"历史记录";
    //[self makeBackItem];

    [self makeUI];
    // Do any additional setup after loading the view.
}



-(void)makeUI{
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;

    
        _allVcArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];

 
    QJEspenseViewController * Qvc =[[QJEspenseViewController alloc]init];
    Qvc.title =@"消费记录";
    [_allVcArray addObject:Qvc];
    
    QJConsultViewController * Cvc =[[QJConsultViewController alloc]init];
    Cvc.title =@"咨询记录";
    [_allVcArray addObject:Cvc];
    self.segmentView.delegate = self;
    [_segmentView buildUI];
    [_segmentView selectTabWithIndex:0 animate:NO];
//    [_segmentView showRedDotWithIndex:0];
//


}

#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_allVcArray count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _allVcArray[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
}


#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height  )];
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
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
