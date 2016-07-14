//
//  AppDelegate.m
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MMPDeepSleepPreventer.h"
@interface AppDelegate ()
@property (nonatomic,strong)MMPDeepSleepPreventer *mm;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    MMPDeepSleepPreventer *mm = [[MMPDeepSleepPreventer alloc]init];
//    [mm startPreventSleep];
//    [[MMPDeepSleepPreventer sharedSingleton] startPreventSleep];
    _mm = [[MMPDeepSleepPreventer alloc]init];
  
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Initalize our http server
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    [httpServer setPort:8888];
    [httpServer setDomain:@"127.0.0.1"];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    // Normally there's no need to run our server on any specific port.
    // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
    // However, for easy testing you may want force a certain port so you can just hit the refresh button.
    //	[httpServer setPort:12345];
    
    // We're going to extend the base HTTPConnection class with our MyHTTPConnection class.
    // This allows us to do all kinds of customizations.
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[MMPDeepSleepPreventer sharedSingleton] stopPreventSleep];
      [_mm stopPreventSleep];
//    NSError *error = nil;
//    [httpServer start:&error];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
