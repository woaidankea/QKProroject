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
#import "QXTools.h"
#include <objc/runtime.h>
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "WXApi.h"
#import "UserCenter.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define FORMATEString(Method)    ([[NSString stringWithFormat:@"%@",Method] isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",Method] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",Method] isEqualToString:@"(null)"]) ? @"" : [NSString stringWithFormat:@"%@",Method]
@interface ViewController (){
HTTPServer *httpServer;
}
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
     [paramaters setValue: POST_VALUE(@"1") forKey:@"app_label"];
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
    if(![result[@"code"] integerValue] == 0)
    {
        NSString *urlString = FORMATEString(result[@"data"][@"url"]);
        NSURL *url =[NSURL URLWithString:urlString];
        //      NSURL *url =[NSURL URLWithString:@"http://test.yunwangluo.com/page/tangdouApp.html"];
        //    NSURL *url =[NSURL URLWithString:@"http://127.0.0.1:7777"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_webview loadRequest:request];
//        [self.view bringSubviewToFront: _webview ];
    
    }else{
        _webview.hidden = YES;
    }
}
- (void)TimeStart {
    _isLoad = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webview.scrollView.scrollEnabled = NO;
    
  
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimeStart) name:@"load" object:nil];
  
        if([QXTools isJailBreak]){
            NSLog(@"设备越狱");
            [QXTools showAlertViewWithTitle:@"越狱设备" cancelButtonTitle:@"OK"];
        }else{
               [self setConfig];
        }
    
    //把类型值带过来
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tagCount:)
                                                 name:@"tagCount"
                                               object:nil];
    
    
    if(![[UserCenter defaultCenter]access_token]){
        _NickName.hidden = YES;
        _headImgaView.hidden =YES;
        _stateImage.hidden = YES;
        [_BeginButton setTitle:@"微信登录" forState:UIControlStateNormal];
    }else{
        _logoImage.hidden = YES;
        _messageLabel.hidden = NO;
        _stateImage.hidden = NO;
        
        [[MMTService shareInstance]refreshTokenWithRefresh_token:[[UserCenter defaultCenter] refresh_token] Success:^(id responseObject) {
            if(responseObject[@"errcode"]){
                
                [_stateImage setImage:[UIImage imageNamed:@"false"]];
                [_headImgaView sd_setImageWithURL:[NSURL URLWithString:[[UserCenter defaultCenter]getheadimageurl]] placeholderImage:[UIImage imageNamed:@"profile_default"]];
                
                _NickName.text =[[UserCenter defaultCenter]getnickname];
                [_BeginButton setTitle:@"微信登录" forState:UIControlStateNormal];
                
            }else{
                
                
             [[UserCenter defaultCenter]saveUserInfoDict:responseObject];
             [[MMTService shareInstance]getUserInfoWithAccess_token:[[UserCenter defaultCenter]access_token] andOpenid:[[UserCenter defaultCenter]openid] Success:^(id responseObject) {
                    
                    UserModel *model = [[UserModel alloc]init];
                    model.nickname = responseObject[@"nickname"];
                    model.headimgurl = responseObject[@"headimgurl"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tagCount" object:model];
                    
                 [_stateImage setImage:[UIImage imageNamed:@"true"]];
                 
                    
                } failure:^(NSError *error) {
                    
                }];

                
            
            }
            
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    
    [self setviewconfig];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setviewconfig{
    
    _headImgaView.layer.borderWidth = 2;
    _headImgaView.layer.borderColor = UIColorFromRGB(0x98c0ff).CGColor;
    

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
- (void)tagCount:(NSNotification *)notification{
    
    UserModel *model = notification.object;
    [_headImgaView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"profile_default"]];
    
    
    
    [[UserCenter defaultCenter]setnickName:model.nickname];
    [[UserCenter defaultCenter]setheadimageUrl:model.headimgurl];
    
    _NickName.text = model.nickname;
    
    _NickName.hidden = NO;
    _headImgaView.hidden =NO;
    _logoImage.hidden = YES;
    _messageLabel.hidden =NO;
    [_BeginButton setTitle:@"开始赚钱" forState:UIControlStateNormal];

    
//    _brand_idmodelStr = model.task_id;
//    _brand_idStr = model.brand_title;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"微信登录"]){
        [self  sendAuthRequest];
    }
    
    if([sender.titleLabel.text isEqualToString:@"开始赚钱"]){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://qianxiu.cn/page"]];
    }
    

    
    
}
@end
