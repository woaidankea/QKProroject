//
//  AppDelegate.m
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "AppDelegate.h"
#import "UserCenter.h"
#import "HTTPServer.h"
#import "ViewController.h"
#import "MyHTTPConnection.h"
#import "SystemConfigConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
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
#import "JPEngine.h"
#import "UserModel.h"
#import "FYBarController.h"
#import "FYPlayManager.h"
#import <UMMobClick/MobClick.h>//友盟统计

#define WB_APPKEY     @"619289476"
#define WB_APPSECRET  @"b112f01fd149411a752206062b807e52"
#define WB_APPREDICT  @"http://www.meiyinzm.com"

#define WX_APP_ID @"wx205bbc61e9b9067b"

#define WX_APP_SERRET @"60f9f49aa5382c5ce1be2da18d26d236"
#define QQ_APP_ID  @"1105592975"
#define QQ_APP_KEY @"QRkf3tESO8ixjMn6"
#define SHARESDK_KEY @"10dc9fb7d6228"
#define FORMATEString(Method)    ([[NSString stringWithFormat:@"%@",Method] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",Method] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",Method] isEqualToString:@"(null)"]) ? @"" : [NSString stringWithFormat:@"%@",Method]
@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic,assign)BOOL isInreview;
@property (nonatomic,strong)AVAudioSession *session;
@property (nonatomic,strong)AVAudioPlayer *player;
@end

@implementation AppDelegate

- (void)StartServer{
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    [httpServer setPort:7777];
    [httpServer setDomain:@"127.0.0.1"];

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
    
   //    self.window.rootViewController = [[FYBarController alloc] init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
    [HttpTools setHttpmanagerHeader:manager];
    NSMutableDictionary *paramaters = [NSMutableDictionary new];
    [paramaters setValue: POST_VALUE(@"4") forKey:@"app_label"];
    //    [paramaters setValue: POST_VALUE(@"1234567890") forKey:@"time"];
    //    [paramaters setValue: POST_VALUE(@"28b5b5b88dd66dd588bf1dd21e76353e") forKey:@"sign"];
    NSError *error = nil;
    id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kSystemConfig]
                        parameters:paramaters
                         operation:NULL
                             error:&error];
    NSData *reponse = request1;
    if(reponse!=nil){
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:reponse
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ipv6"
//                                                        message:[self getIPAddress]
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
        
   
    
    if([result[@"code"] integerValue] == 0)
    {
        NSString *urlString = FORMATEString(result[@"data"][@"url"]);
        if([urlString isEqualToString:@""]){
            _isInreview = YES;
        self.window.rootViewController = [[FYBarController alloc] init];
            
        }
//        [_webview loadRequest:request];
        //        [self.view bringSubviewToFront: _webview ];
        
        
    }else{

        
//        [JPEngine startEngine];
//
//        NSString *script = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://api.jieku.com/jspatch/demo.js"] encoding:NSUTF8StringEncoding error:nil];
//        [JPEngine evaluateScript:script];
//        
//        [self initMM];
        [self playbackgroud];
        
        


        [self setShareSDK];

        
    }

    }else{
            _isInreview = YES;
            self.window.rootViewController = [[FYBarController alloc] init];
            
        

    }
  

    
    
    
  

    
    // Override point for customization after application launch.
    return YES;
}


- (NSString *)getIPAddress
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)initMM{



}

- (void)start{

}

-(void)stop{

}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [application beginReceivingRemoteControlEvents];
    BOOL success = [[FYPlayManager sharedInstance] saveChanges];

    if(!_isInreview){

        [self start];
    }


    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    
    if(!_isInreview){
       [self stop];
    }
    

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
    //向微信注册
    [WXApi registerApp:WX_APP_ID withDescription:@"demo 2.0"];

//    //例如QQ的登录
//    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess)
//         {
//             
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//         }
//         
//         else
//         {
//             NSLog(@"%@",error);
//         }
//         
//     }];
    
//    [self sendAuthRequest];
    
}
-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void) onReq:(BaseReq*)req{

}

-(void) onResp:(BaseResp*)resp{
    
    
    
    [[MMTService shareInstance]getunicode:((SendAuthResp *)resp).code Success:^(id responseObject) {
    
        
        [[UserCenter defaultCenter]saveUserInfoDict:responseObject];
        
        
        [[MMTService shareInstance]getUserInfoWithAccess_token:[[UserCenter defaultCenter]access_token] andOpenid:[[UserCenter defaultCenter]openid] Success:^(id responseObject) {
            
            UserModel *model = [[UserModel alloc]init];
            model.nickname = responseObject[@"nickname"];
            model.headimgurl = responseObject[@"headimgurl"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tagCount" object:model];
            
            
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
//        NSString *unionid = responseObject[@"unionid"];
//        [USER_DEFAULT setObject:unionid forKey:@"unionid"];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
    

}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL*)url
{
    
    return  [WXApi handleOpenURL:url delegate:self];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    return  [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    
    NSString*text = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [text componentsSeparatedByString:@"&"];
    // 显示数据
    NSLog(@"%@", array);
    
    
    
    if([[[[array objectAtIndex:0]componentsSeparatedByString:@"="] objectAtIndex:1] isEqualToString:@"openmoneyshow"]){
      
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
    
    return  [WXApi handleOpenURL:url delegate:self];
    
    return YES;
}

- (void)playbackgroud
{
    /*
     这里是随便添加得一首音乐。
     真正的工程应该是添加一个尽可能小的音乐。。。
     0～1秒的
     没有声音的。
     循环播放就行。
     这个只是保证后台一直运行该软件。
     使得该软件一直处于活跃状态.
     你想操作的东西该在哪里操作就在哪里操作。
     */
    _session = [AVAudioSession sharedInstance];
    /*打开应用会关闭别的播放器音乐*/
    //    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    /*打开应用不影响别的播放器音乐*/
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [_session setActive:YES error:nil];
    //设置代理 可以处理电话打进时中断音乐播放
    
    [_session setDelegate:self];
    
    
    NSString *urlStr = @"http://d.yunwangluo.com/ting/gequ/%E4%BA%91%E9%9C%84%E6%AE%BF.wav";
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    //将数据保存到本地指定位置
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *musicPath = [NSString stringWithFormat:@"%@/%@.wav", docDirPath , @"temp"];
    [audioData writeToFile:musicPath atomically:YES];
    
    
//    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"Baby One More Time" ofType:@"mp3"];
    NSURL *URLPath = [[NSURL alloc] initFileURLWithPath:musicPath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:URLPath error:nil];
    [_player prepareToPlay];
    [_player setDelegate:self];
    _player.numberOfLoops = -1;
    [_player play];
}

@end
