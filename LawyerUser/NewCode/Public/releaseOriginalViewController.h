//
//  releaseOriginalViewController.h
//  prawnShare
//
//  Created by MYMAc on 2018/7/24.
//  Copyright © 2018年 DongliWuxian. All rights reserved.
//

#import "BaseViewController.h"

@interface releaseOriginalViewController : BaseViewController

- (IBAction)imageAction:(UIButton *)sender;

- (IBAction)DTouchImage:(UIButton *)sender;

- (IBAction)DeleAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *BackView;


@end
