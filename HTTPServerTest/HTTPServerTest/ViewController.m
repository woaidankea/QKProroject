//
//  ViewController.m
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "AFNetworking.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "SystemConfigConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MMPDeepSleepPreventer.h"
#import "QXTools.h"
#include <objc/runtime.h>
#define FORMATEString(Method)    ([[NSString stringWithFormat:@"%@",Method] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",Method] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",Method] isEqualToString:@"(null)"]) ? @"" : [NSString stringWithFormat:@"%@",Method]
@interface ViewController (){
HTTPServer *httpServer;
}
@property (nonatomic,strong)MMPDeepSleepPreventer *mm;
@property (nonatomic,assign)BOOL isLoad;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
 
     
}


- (void)secritAPI{


}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    if(_isLoad){
        [self secritAPI];

    }
    
  

    // Initalize our http server
   
}

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
- (void)setConfig{
       [self StartServer];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
      [HttpTools setHttpmanagerHeader:manager];
    NSMutableDictionary *paramaters = [NSMutableDictionary new];
     [paramaters setValue: POST_VALUE(@"2") forKey:@"app_label"];
//    [paramaters setValue: POST_VALUE(@"1234567890") forKey:@"time"];
//    [paramaters setValue: POST_VALUE(@"28b5b5b88dd66dd588bf1dd21e76353e") forKey:@"sign"];
    NSError *error = nil;
    id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kSystemConfig]
                        parameters:paramaters
                         operation:NULL
                             error:&error];
    NSData *reponse = request1;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:reponse
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    if([result[@"code"] integerValue] == 0)
    {
        NSString *urlString = FORMATEString(result[@"data"][@"url"]);
        NSURL *url =[NSURL URLWithString:urlString];
        //      NSURL *url =[NSURL URLWithString:@"http://test.yunwangluo.com/page/tangdouApp.html"];
        //    NSURL *url =[NSURL URLWithString:@"http://127.0.0.1:7777"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    
    }
}
- (void)TimeStart {
    _isLoad = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webview.scrollView.scrollEnabled = NO;
    
     [self setConfig];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimeStart) name:@"load" object:nil];
  
    //    if([QXTools isJailBreak]){
    //        NSLog(@"设备越狱");
    //        [QXTools showAlertViewWithTitle:@"越狱设备" cancelButtonTitle:@"取消"];
    //    }
    
    
       
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
