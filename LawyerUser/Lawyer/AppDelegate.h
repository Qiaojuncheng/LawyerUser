//
//  AppDelegate.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;


@end

