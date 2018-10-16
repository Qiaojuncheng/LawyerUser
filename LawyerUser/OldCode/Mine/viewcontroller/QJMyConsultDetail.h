//
//  QJMyConsultDetail.h
//  Lawyer
//
//  Created by MYMAc on 2017/10/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"
#import "QJMyConsultModel.h"
@interface QJMyConsultDetail : BaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;

@property (weak, nonatomic) IBOutlet UILabel *HuifuName;

@property (weak, nonatomic) IBOutlet UILabel *TImeLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BackViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;

@property (weak, nonatomic) IBOutlet UILabel *QuestLB;

@property (weak, nonatomic) IBOutlet UILabel *ReplyLB;

@property (weak, nonatomic) IBOutlet UILabel *NoReplyLB;

@property (weak, nonatomic) IBOutlet UIView *replyView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *QuestHeight;
 @property (weak, nonatomic) IBOutlet NSLayoutConstraint *ReplyViewHeight;
@property(strong , nonatomic) QJMyConsultModel * model;

@end
