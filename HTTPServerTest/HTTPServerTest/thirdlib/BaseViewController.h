//
//  BaseViewController.h
//  AMen
//
//  Created by libo on 15/10/19.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController

@property (nonatomic,strong,nullable)NSString *url;
@property (nonatomic,strong,nullable)NSString *moudleId;
@property (assign,nonatomic)BOOL isFullScreen;
-(void)setBusyIndicatorVisible:(BOOL)visible;
-(void)setleftBarItemWith:(NSString *)imageNamed;
- (void)setleftBarItemWith:(nullable NSString *)imageNamed;
-(void)setrightBarItemWith:(NSString *)imageNamed;
//延迟butten的点击
- (void)delayToEnableUserInteraction:(UIButton *)sender;

- (void)addNotification;

- (void)removeNotification;



@end
