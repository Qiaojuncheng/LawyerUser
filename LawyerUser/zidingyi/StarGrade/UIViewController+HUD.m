/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "UIViewController+HUD.h"

#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    
    for ( UIView * mb  in  view.subviews ) {
        if([mb isKindOfClass:[MBProgressHUD class]]){
            
            [mb removeFromSuperview];
        }
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    [HUD show:YES];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.activityIndicatorColor =[UIColor whiteColor];

    [self setHUD:HUD];
    
    HUD.labelText = hint;
    HUD.label.textColor = [UIColor whiteColor];
}

- (void)showHint:(NSString *)hint
{
    
    
    
    UIView *view = [[UIApplication sharedApplication].delegate window];

    for (UIView * huded in view.subviews) {
        if ([huded isKindOfClass:[MBProgressHUD class]]) {
            [huded removeFromSuperview];
        }
    }
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.backgroundColor = [UIColor blackColor];

    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.label.textColor = [UIColor whiteColor];
    hud.activityIndicatorColor =[UIColor whiteColor];

    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
-(void)showHint:(NSString *)hint inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.margin = 10.f;
    hud.yOffset = view.centerY/2;
    hud.activityIndicatorColor =[UIColor whiteColor];

    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
-(void)showProgressImageViewInView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    NSArray *arr = @[[UIImage imageNamed:@"01"],
                     [UIImage imageNamed:@"02"],
                     [UIImage imageNamed:@"03"],
                     [UIImage imageNamed:@"04"],
                     [UIImage imageNamed:@"05"],
                     [UIImage imageNamed:@"06"],
                     [UIImage imageNamed:@"07"],
                     [UIImage imageNamed:@"08"],
                     [UIImage imageNamed:@"09"],
                     [UIImage imageNamed:@"10"],
                     [UIImage imageNamed:@"11"],
                     [UIImage imageNamed:@"12"]];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    imageV.animationImages = arr;
    imageV.animationDuration = 2;
    [imageV startAnimating];
    hud.customView = imageV;
    hud.square = YES;
    hud.activityIndicatorColor =[UIColor whiteColor];

    hud.color = [UIColor clearColor];
    [self setHUD:hud];//有了这一句可以保证[self hideHUD];正常执行

}
- (void)showHint:(NSString *)hint yOffset:(float)yOffset
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.activityIndicatorColor =[UIColor whiteColor];

    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hide:YES];
}

@end
