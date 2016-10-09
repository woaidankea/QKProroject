//
//  MDInterestDetailViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDInterestDetailViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "AppDelegate.h"
#import "DXShareTools.h"
#import <CommonCrypto/CommonDigest.h>

#import "CLProgress.h"
#import "JQIndicatorView.h"
#include <objc/runtime.h>
#import "ViewController.h"


#ifndef NQYoungCloud_UtilsMacro_h
#define NQYoungCloud_UtilsMacro_h

#define DEFAULTCENTER  [NSNotificationCenter defaultCenter]
#define USERDEFAULTS   [NSUserDefaults standardUserDefaults]

//navStudent.modalPresentationStyle = UIModalPresentationFormSheet;
// view 大小  540   620

/**
 图片
 */
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]


/**
 颜色
 */
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**
 系统版本
 */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_0 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320,568), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Pus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_7 ([[[UIDevice currentDevice] systemVersion] intValue]>6 ? YES : NO)
#define IOS_8 ([[[UIDevice currentDevice] systemVersion] intValue]>7 ? YES : NO)

#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 当前语言
 */
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])





// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)





//防止一个头文件被重复包含
#ifndef     COMDEF_H
#define     COMDEF_H
// 头文件内容
#endif


//设置线宽，如果是retina屏，lineWidth设为1,实际显示的宽度是2个像素
#define SETLINEWIDTH(ctx,w) CGContextSetLineWidth(ctx, w/[UIScreen mainScreen].scale)


//在ARC项目中使用 performSelector: withObject: 函数出现“performSelector may cause a leak because its selector is unknown”。
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define USER_DEFAULT_KEY(element) [[NSUserDefaults standardUserDefaults] objectForKey:element]


#endif


@interface MDInterestDetailViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
{
//    NJKWebViewProgressView *_progressView;
//    NJKWebViewProgress *_progressProxy;
}
@property (strong,nonatomic)UIProgressView *progressview;
@end

@implementation MDInterestDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      
 
    [_wkwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.weburl]]]];
//     [[CLProgressHUD shareInstance] showsInsuperview:_wkwebview];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  
}



-(void)setrightBarItem:(NSString *)imageNamed{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [backButton setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    ShareModel *sharemodel = [[ShareModel alloc]init];
    sharemodel.title = @"分享收徒";
    sharemodel.url =  _model.url;
    UIImage *image =[UIImage imageNamed:@"Icon-120"];
    sharemodel.imageArray = @[image];
    sharemodel.desc = @"加入钱秀!每月多赚500元!最靠谱的手机任务平台,每月...";
    
    
    
    [[DXShareTools shareToolsInstance]ShareWithModel:sharemodel andType:TypeQQ];
}
- (void)rightItemAction{
//    [self share];
    
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    [self secritAPI];
    
  

}
- (void)secritAPI{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享收徒";

    [self  setrightBarItem:@"share_top"];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setleftBarItemWith:@"back_ico@2x.png"];
    
    CGRect rect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-64);
    if(IOS_8){
    _wkwebview = [[YPWebView alloc]initWithFrame:rect];
    }
   
    _wkwebview.delegate = self;
    _wkwebview.wkUIDelegateViewController = self;
    [self.view addSubview:_wkwebview];
    
    
    _progressview = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    [_wkwebview addSubview:_progressview];
    //    _wkwebview.UIDelegate =self;
    [self.view addSubview:_wkwebview];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark - NJKWebViewProgressDelegate
#pragma mark - KVO
- (void)YPwebview:(YPWebView *)webview loadProgress:(double)progress{
    [_progressview setAlpha:1.0f];
    [_progressview setProgress:progress animated:YES];
    
    if(progress >= 1.0f) {
        
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_progressview setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [_progressview setProgress:0.0f animated:NO];
//             [[CLProgressHUD shareInstance] dismiss];
        }];
        
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        
    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)YPwebview:(YPWebView *)webview loadTitle:(NSString *)title{
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //    if ([keyPath isEqual:@"estimatedProgress"]) {
    //        if ([self.delegate respondsToSelector:@selector(YPwebview:loadProgress:)]) {
    //            [self.delegate YPwebview:self loadProgress:self.wkWebView.estimatedProgress];
    //        }
    //    }
}

//- (void)share{
//    
//    if(!USER_DEFAULT_KEY(@"token")){
//        
//        [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
//        return;
//        
//        
//    }
//
//    
//    
//    
//    NSMutableArray *shareAry = [NSMutableArray new];
//    
//    NSDictionary *share_wx = @{@"image":@"share_wx",
//                               @"title":@"微信"};
//    NSDictionary *share_wx_timeline = @{@"image":@"share_wx_timeline",
//                                        @"title":@"朋友圈"};
//    NSDictionary *share_qq = @{@"image":@"share_qq",
//                               @"title":@"QQ"};
//    NSDictionary *share_weibo = @{@"image":@"share_weibo",
//                                  @"title":@"新浪微博"};
//    NSDictionary *share_qzone = @{@"image":@"share_qzone",
//                                  @"title":@"QQ空间"};
//    
//    
//    ShareModel *sharemodel = [[ShareModel alloc]init];
//    MDArticleModel *t_model = self.model;
//    //   1.qq  kongjian  pengyouquan  wx  weibo
//    
//    for(MDShareModel *share in t_model.shareConfig){
//        NSLog(@"titile = %@ show = %d platform = %@",share.title,share.show,share.platform);
//        if(share.show==YES){
//            if([share.platform isEqualToString:@"1"]){
//                [shareAry addObject:share_qq];
//            }
//            if([share.platform isEqualToString:@"2"]){
//                [shareAry addObject:share_qzone];
//            }
//            
//            if([share.platform isEqualToString:@"3"]){
//                [shareAry addObject:share_wx_timeline];
//            }
//            
//            if([share.platform isEqualToString:@"4"]){
//                [shareAry addObject:share_wx];
//            }
//            
//            if([share.platform isEqualToString:@"5"]){
//                [shareAry addObject:share_weibo];
//            }
//            
//            
//            
//        }
//        
//    }
//    
//    
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];  //转为字符型
//    
////    NSString *newKey = [self md5:timeString];
//    NSString *MD5 = [timeString substringWithRange:NSMakeRange(6,7)];
//
//    
//    
//    
//    sharemodel.title = t_model.title;
//    sharemodel.url =  [NSString stringWithFormat:@"%@%@.html",t_model.url,MD5];
//    sharemodel.imageArray = @[self.shareImage];
//    sharemodel.desc = t_model.desc;
//    sharemodel.key = [NSString stringWithFormat:@"%@%@",t_model.authcode,MD5];
//    sharemodel.qqbrowser = [NSString stringWithFormat:@"%@%@adi=%@&shareurl=%@",BaseAddress,kqqBrowser,t_model.aid,[self base64StringFromText:sharemodel.url]];
//    [DXShareTools shareToolsInstance].isArticle = YES;
//    [DXShareTools shareToolsInstance].isApprentice = NO;
//    [DXShareTools shareToolsInstance].isSign = NO;
//    
//    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel  viewController:self];
//}

- (NSString *)base64StringFromText:(NSString *)text
{
           NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
//        data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    
}
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
- (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        // Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

//
- (IBAction)shareButtonClick:(id)sender {
    
    ShareModel *sharemodel = [[ShareModel alloc]init];
    sharemodel.title = @"分享收徒";
    sharemodel.url =  _model.url;
    UIImage *image =[UIImage imageNamed:@"AppIcon"];
    sharemodel.imageArray = @[@"http://test.yunwangluo.com/static/img/state-over.png"];
    sharemodel.desc = @"加入钱秀!每月多赚500元!最靠谱的手机任务平台,每月...";
    
    
    
    [[DXShareTools shareToolsInstance]ShareWithModel:sharemodel andType:TypeQQ];
}

//- (void)rightItemAction{
//    
//    [self share];
//    
//    
//}
- (NSString *)md5:(NSString *)string {
    
    // 1. 导入库文件
    //    #import <CommonCrypto/CommonDigest.h>
    
    // 需要MD5加密的字符
    const char *cStr = [string UTF8String];
    // 设置字符加密后存储的空间
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    // 参数三：编码的加密机制
    CC_MD5(cStr, (UInt32)strlen(cStr), digest);
    
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:16];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        
        [result appendFormat:@"%02x",digest];
        
    }
    
    result = (NSMutableString *)[result stringByAppendingString:@".png"];
    
    return result;
    
}


@end
