//
//  QKDevice.m
//  HTTPServerTest
//
//  Created by jieku on 16/7/13.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "QKDevice.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>
#import "NSString+MD5.h"
#define POST_VALUE(_VAL)  (_VAL)?(_VAL):@""
@implementation QKDevice
+(NSDictionary *)systemInfoData{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    NSString *qx_version = [NSString stringWithFormat:@"%@|%@|%@",[UIDevice currentDevice].systemVersion, [[NSBundle mainBundle] bundleIdentifier],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
     NSString *qx_scheme = @"qkapp";
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];//转为字符型
    NSString *qx_datetime = [timeString substringWithRange:NSMakeRange(0,10)];
    NSString *qx_auth = [NSString stringWithFormat:@"%@|%@",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    
    [dict setObject:qx_version forKey:@"qx_version"];
    [dict setObject:qx_scheme forKey:@"qx_scheme"];
    [dict setObject:qx_datetime forKey:@"qx_datetime"];
    [dict setObject:qx_auth forKey:@"qx_auth"];
    
    
    
    NSString *signatureParam = [self generateSignatureParams:dict];
    [dict setValue:POST_VALUE(signatureParam) forKey:@"qx_sign"];

    
    
//    USER_DEFAULT_KEY(@"idfa");
//    NSString *systemInfo = [NSString stringWithFormat:@"%@,%@,%f",strModel,USER_DEFAULT_KEY(@"idfa"),[[UIDevice currentDevice].systemVersion floatValue]];
    
    return dict;
}

+ (NSString *)generateSignatureParams:(NSDictionary *)paramDic
{
    NSArray *keysArray = [paramDic allKeys];
    NSMutableArray *paramArray = [[NSMutableArray alloc]init];
    
    for (NSString *key in keysArray) {
        [paramArray addObject:[NSString stringWithFormat:@"%@=%@",key,paramDic[key]]];
    }
    NSArray *resultArray = [paramArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    
    NSMutableString *param = [[NSMutableString alloc]init];
    
    for (int i = 0 ; i<resultArray.count; i++) {
        
        [param appendString:resultArray[i]];
        if (i<resultArray.count-1) {
            
            [param appendString:@"&"];
        }
    }
    
    [param appendString:kTransferKey];
    NSString *signature   = [param MD5Hash];
    
    return signature;
}

@end
