//
//  CLProgressHUD.m
//  HUD
//
//  Created by zyyt on 16/1/13.
//  Copyright © 2016年 zyyt. All rights reserved.
//
#define CLScreenWidth [UIScreen mainScreen].bounds.size.width
#define CLScreenHeight [UIScreen mainScreen].bounds.size.height
#define CLScreenBounds [UIScreen mainScreen].bounds
#import "CLProgressHUD.h"
#import "JQIndicatorView.h"
@interface CLProgressHUD()
@property (weak,nonatomic)CAShapeLayer *shapLayer;
@property (weak,nonatomic)UILabel *refreshLabel;
@property (weak,nonatomic)UIWindow * currentWindow;
@property (strong,nonatomic)UIImageView *backView;
@property (weak,nonatomic)NSTimer * timer;
@property (strong,nonatomic) JQIndicatorView  *indicator;
@end
@implementation CLProgressHUD
+ (id)shareInstance{
    static CLProgressHUD *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init{
    if (self = [super init]) {
        //        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [[UIColor colorWithWhite:0.292 alpha:1.000] colorWithAlphaComponent:0.5];
//        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
//        [self addBGview];
      
    }
    return self;
}
- (void)addBGview{
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.frame = CGRectMake(50, 90, self.frame.size.width, 400);
    // 添加毛玻璃
    [self addSubview:effe];
    
}
- (UIWindow *)currentWindow{
    if (_currentWindow == nil) {
        
        UIWindow * currentWindow = [UIApplication sharedApplication].keyWindow;
        _backView = [[UIImageView alloc]initWithFrame:currentWindow.bounds];
//        _backView.backgroundColor = [UIColor colorWithWhite:0.412 alpha:0.500];
        _backView.image = [UIImage imageNamed:@"jiazai-1"];
        [currentWindow addSubview:_backView];
        _currentWindow = currentWindow;
    }
    return _currentWindow;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    
    
    self.frame = CGRectMake(0, 2,newSuperview.bounds.size.width, newSuperview.bounds.size.height-2);
    _backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, newSuperview.bounds.size.width, newSuperview.bounds.size.height-2)];
    //        _backView.backgroundColor = [UIColor colorWithWhite:0.412 alpha:0.500];
    _backView.image = [UIImage imageNamed:@"jiazai-1"];
    [self addSubview:_backView];
    [self addSubview:self.indicator];
    self.backgroundColor = [UIColor blackColor];
     _indicator.center = CGPointMake(self.center.x - 60, self.center.y);
           [_indicator startAnimating];
    //    self.center = CGPointMake(CLScreenWidth/2, CLScreenHeight/2 - 20*CLScreenWidth/375);
}
- (JQIndicatorView *)indicator{
    if(!_indicator){
        _indicator = [[JQIndicatorView alloc] initWithType:JQIndicatorTypeBounceSpot1 tintColor:[UIColor colorWithHue:106/255.0 saturation:2/255.0 brightness:207/255.0 alpha:1]];
        //        indicator.tag = 101 + indexPath.row;
        
       
        [_indicator startAnimating];
        
        
    }
    return _indicator;
}

- (void)showsInsuperview:(UIView *)superview{
    self.hidden = NO;
    self.backView.hidden = NO;
    //
    
    superview.backgroundColor = [UIColor redColor];
    [superview addSubview:self];
   
}

- (void)showsInWindow:(UIWindow *)window{
    self.hidden = NO;
    self.backView.hidden = NO;
    //
    
    
    [window addSubview:self];
    _indicator.center = CGPointMake(self.center.x - 50, self.center.y);
}

- (void)shows{
//    [self timer];
//    self.timer.fireDate=[NSDate distantPast];//恢复定时器
//    self.hidden = NO;
//    self.backView.hidden = NO;
//

    
    [self.currentWindow addSubview:self];
     _indicator.center = CGPointMake(self.center.x - 50, self.center.y);
//    [self creatShplayer];
}
- (void)dismiss{
//    self.hidden = YES;
//    self.backView.hidden = YES;
    [self removeFromSuperview];
//    [self.shapLayer removeAnimationForKey:@"CLAnimation"];
//    self.timer.fireDate=[NSDate distantFuture];
}
@end
