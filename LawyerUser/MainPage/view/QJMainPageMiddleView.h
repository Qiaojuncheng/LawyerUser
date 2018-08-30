//
//  QJMainPageMiddleView.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/19.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJMainPageMiddleView : UIView

@property (weak, nonatomic) IBOutlet UIView *LeftView;

@property (weak, nonatomic) IBOutlet UIView *FirstView;

@property (weak, nonatomic) IBOutlet UIView *SecondView;

@property (weak, nonatomic) IBOutlet UIView *ThirdView;
@property (weak, nonatomic) IBOutlet UIView *LastView;


-(void)MakeMiddleViewUI;

@end
