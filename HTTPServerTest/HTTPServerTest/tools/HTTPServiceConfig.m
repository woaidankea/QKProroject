//
//  HTTPServiceConfig.m
//  HTTPServerTest
//
//  Created by jieku on 16/7/14.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "HTTPServiceConfig.h"
#import "MyHTTPConnection.h"
#import "SystemConfigConnection.h"
#import "KeyStateConnection.h"
@implementation HTTPServiceConfig
+ (void)HttpServiceConfig:(HTTPServer *)httpServer
{
     [httpServer setConnectionClass:[MyHTTPConnection class]];  //获取用户信息
    
     [httpServer setConnectionClass:[SystemConfigConnection class]];  //获取设置信息
     [httpServer setConnectionClass:[KeyStateConnection class]];  //获取用户信息

    
}
@end
