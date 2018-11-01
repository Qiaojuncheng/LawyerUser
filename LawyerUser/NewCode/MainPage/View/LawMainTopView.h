//
//  LawMainTopView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJScrollTextView2.h"
@interface LawMainTopView : UIView <LMJScrollTextView2Delegate>
typedef void (^selectAdsIndexBlock)(NSInteger index);
typedef void (^selectItemBlock)(NSInteger index);
@property (weak, nonatomic) IBOutlet LMJScrollTextView2 *scrollTextView;

@property (copy, nonatomic) selectAdsIndexBlock adsselectBlock;
@property (copy, nonatomic) selectItemBlock ItemselectBlock;
-(void)makeItemWithTitleArray:(NSArray*)TitleArray ImageArray:(NSArray*)ImageArray;
-(void)makeDataWithScrollLBArray:(NSArray * )titleArray;
- (IBAction)TopBtnACtion:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *MoreDataLB;



@end
