//
//  AppDelegate.m
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPServer.h"
#import "ViewController.h"
#import "MyHTTPConnection.h"
#import "SystemConfigConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MMPDeepSleepPreventer.h"
#import "QXTools.h"
#import "MDInterestDetailViewController.h"
#import "DXShareTools.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//新浪微博SDK头文件
#import "WeiboSDK.h"
//微信SDK头文件
#import "WXApi.h"
#include <objc/runtime.h>



#define WB_APPKEY     @"619289476"
#define WB_APPSECRET  @"b112f01fd149411a752206062b807e52"
#define WB_APPREDICT  @"http://www.meiyinzm.com"

#define WX_APP_ID @"wx3e96ccb7fc46ed42"

#define WX_APP_SERRET @"efd1f7a3d5185eac5b3c9c691a9f0b59"
#define QQ_APP_ID  @"1105592975"
#define QQ_APP_KEY @"QRkf3tESO8ixjMn6"
#define SHARESDK_KEY @"10dc9fb7d6228"

@interface AppDelegate ()
@property (nonatomic,strong)MMPDeepSleepPreventer *mm;
@end

@implementation AppDelegate

- (void)StartServer{
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    [httpServer setPort:7777];
    [httpServer setDomain:@"127.0.0.1"];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    
    // Serve files from our embedded Web folder
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    //    DDLogInfo(@"Setting document root: %@", webPath);
    
    [httpServer setDocumentRoot:webPath];
    
    
    NSError *error = nil;
    if(![httpServer start:&error])
    {
        //        DDLogError(@"Error starting HTTP Server: %@", error);
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
     _mm = [[MMPDeepSleepPreventer alloc]init];
    [self setShareSDK];
    
    
    
    
    
    
    
  

    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
//    [[MMPDeepSleepPreventer sharedSingleton] startPreventSleep];
   
      [_mm startPreventSleep];
//    NSError *error = nil;
//    
//    [httpServer start:&error];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    
//    
//            ViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//
//    
//    [self.window setRootViewController:loginVC];

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[MMPDeepSleepPreventer sharedSingleton] stopPreventSleep];
      [_mm stopPreventSleep];
//    NSError *error = nil;
//    [httpServer start:&error];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)setShareSDK{
    
    [ShareSDK registerApp:SHARESDK_KEY
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                 [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class]
                            tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:WB_APPKEY
                                           appSecret:WB_APPSECRET
                                         redirectUri:WB_APPREDICT
                                            authType:SSDKAuthTypeBoth];
                 break;
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WX_APP_ID
                                       appSecret:WX_APP_SERRET];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQ_APP_ID
                                      appKey:QQ_APP_KEY
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL*)url
{
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
   
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSString*text = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [text componentsSeparatedByString:@"&"];
    // 显示数据
    NSLog(@"%@", array);
    
    
    
    if([[[[array objectAtIndex:0]componentsSeparatedByString:@"="] objectAtIndex:1] isEqualToString:@"openmoneyshow"]){
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[[array objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:1]]];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//        
//        
//        ViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//        
//        UINavigationController *mainContrl =  [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
//        [mainContrl.navigationBar setTintColor:[UIColor whiteColor]];
//        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        [self.window setRootViewController:mainContrl];
        //Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
       // NSObject *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        
      //  BOOL isopen = [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:@"com.apple.mobilesafari"];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"load" object:nil];
        

    }

    
    
    
    if([[[[array objectAtIndex:0]componentsSeparatedByString:@"="] objectAtIndex:1] isEqualToString:@"shareurl"]){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MDInterestingArticleViewController" bundle:nil];
        
        ShareModel *model =[[ShareModel alloc]init];
        model.url = [[[array objectAtIndex:1] componentsSeparatedByString:@"url="] objectAtIndex:1];
        model.weburl = [[[array objectAtIndex:2] componentsSeparatedByString:@"weburl="] objectAtIndex:1];
    

        MDInterestDetailViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"MDInterestDetailViewController"];
          loginVC.model = model;
        UINavigationController *mainContrl =  [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        [mainContrl.navigationBar setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
                mainContrl.navigationBar.translucent = NO;
        [self.window.rootViewController presentViewController:mainContrl animated:NO completion:nil];
        
        
//        [self.window setRootViewController:mainContrl];
      //  [self setShareSDK];
    }
    
    return YES;
}
@end
