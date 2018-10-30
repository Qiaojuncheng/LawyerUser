//
//  QJSelectItemView.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/21.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJSelectItemView.h"
#import "QJTSelectItemableCell.h"
@interface QJSelectItemView ()


@end

@implementation QJSelectItemView


-(instancetype)initWithFrame:(CGRect)frame{

    self =[super initWithFrame:frame];
    
    self.backgroundColor =[UIColor colorWithRed:107/225.0 green:108/225.0  blue:109/225.0  alpha:0.5];
    return self;

 }
-(void)viewWasTap:(UITapGestureRecognizer *)tap{
    
     [self dismissView];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[QJSelectItemView class]]) {
        return YES;
    }
    return NO;
} -(void)makeUI{
    
    
  

    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewWasTap:)];
     gesture.delegate= self;
     _TV  =[[UITableView alloc]initWithFrame:CGRectMake(0,self.frame.size.height +50,self.frame.size.width , 200) style:UITableViewStylePlain];
    
    _TV.backgroundColor =[UIColor whiteColor];
    _TV.delegate= self;
    _TV.tableFooterView =[[UIView alloc] init];
    _TV.dataSource = self;
    [self addSubview:_TV];
    [self addGestureRecognizer:gesture];
    
    
    
     HeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width  ,50)];
    
    HeaderView.backgroundColor =  [UIColor whiteColor];
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.text  = self.ViewTitlt;
    titleLabel.textColor =[UIColor blackColor];
    [HeaderView addSubview:titleLabel];
    
    
    UILabel * linLbale =[[UILabel alloc]initWithFrame:CGRectMake(0, 49, self.frame.size.width, 1)];
    linLbale.backgroundColor = [UIColor colorWithRed:33/255.0 green:101/255.0 blue:176/255.0 alpha:0.8];
    [HeaderView addSubview:linLbale];
    
    [self addSubview:HeaderView];

}

-(NSMutableArray *)ViewDatArray{

    if (!_ViewDatArray) {
        _ViewDatArray =[[NSMutableArray alloc]init];
     }
     return _ViewDatArray;
}
-(NSString *)ViewTitlt{

    return _ViewTitlt;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QJTSelectItemableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJTSelectItemableCell" owner:self options:nil]lastObject];
    }
    cell.MiddleLB.text= _ViewDatArray[indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"sdfs");

    self.selectWithIndexBlcik((int)indexPath.row);

    [self dismissView];
}

 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ViewDatArray.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 50;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;

}

//-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

//    UIView * HeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width  ,50)];
//    
//    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
//     titleLabel.textAlignment =  NSTextAlignmentCenter;
//    titleLabel.text  = self.ViewTitlt;
//    titleLabel.textColor =[UIColor blackColor];
//    [HeaderView addSubview:titleLabel];
//
//    
//    UILabel * linLbale =[[UILabel alloc]initWithFrame:CGRectMake(0, 49, self.frame.size.width, 1)];
//    linLbale.backgroundColor = [UIColor colorWithRed:33/255.0 green:101/255.0 blue:176/255.0 alpha:0.8];
//    [HeaderView addSubview:linLbale];
//    
//    
//    return HeaderView;
//
//}


-(void)showView{
    [self makeUI];

    [UIView animateWithDuration:0.4 animations:^{
       _TV.frame =CGRectMake(0,self.frame.size.height - 200 ,self.frame.size.width , 200) ;
    
        HeaderView.frame = CGRectMake(0, self.frame.size.height -250, self.frame.size.width  ,50);
    }];

}
-(void)dismissView{
 
    [UIView animateWithDuration:0.4 animations:^{
       _TV.frame =CGRectMake(0,self.frame.size.height  +50  ,self.frame.size.width , 200) ;
        
     HeaderView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width  ,50);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
 

}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
