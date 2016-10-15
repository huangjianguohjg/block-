//
//  HJGGetLocalMessageController.h
//  block获取位置
//
//  Created by 黄建国 on 2016/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IOS8 [[[UIDevice currentDevice] systemVersion]floatValue]>=8.0
@interface HJGGetLocalMessageController : UIViewController
@property (nonatomic, strong) void(^block)(NSString *value);
@end
