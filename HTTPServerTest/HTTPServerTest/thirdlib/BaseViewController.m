//
//  BaseViewController.m
//  AMen
//
//  Created by libo on 15/10/19.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController (){
    int _busyCount;
}


@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)delayToEnableUserInteraction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    [self performSelector:@selector(delayToEnableUser:) withObject:sender afterDelay:1];
}

- (void)delayToEnableUser:(UIButton *)sender{
    sender.userInteractionEnabled = YES;
}


-(void)setleftBarItemWith:(NSString *)imageNamed{

    
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_ico.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -17;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem, nil];
    
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [self.navigationItem setLeftBarButtonItem:backItem];
}


- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setrightBarItemWith:(NSString *)imageNamed{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"返回钱秀" forState:UIControlStateNormal];

    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -17;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBar,nil];

}


- (void)rightItemAction{
    
}


- (void)addNotification{}

- (void)removeNotification{}

- (void)dealloc{
    [self removeNotification];
}

@end
