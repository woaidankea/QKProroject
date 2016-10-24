//
//  MMTService.m
//  Medicalmmt
//
//  Created by gulei on 16/2/23.
//  Copyright © 2016年 gulei. All rights reserved.
//

#import "MMTService.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFNetworking.h"
#import "ServiceConstant.h"
#import "NSString+MD5.h"
#import "UtilsMacro.h"
#import "UserCenter.h"

@implementation MMTService

#pragma mark - Life.Cycle

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (id)shareInstance
{
    static MMTService *man = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        man = [[MMTService alloc]init];
    });
    
    return man;
}

- (void)reset
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

-(NSString *)generateSignatureParams:(NSDictionary *)paramDic
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



- (void)getunicode:(NSString *)code
           Success:(Success)success
           failure:(Failure)failure{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    
    
    NSString *postUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx205bbc61e9b9067b&secret=60f9f49aa5382c5ce1be2da18d26d236&code=%@&grant_type=authorization_code",code];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:postUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         NSDictionary *resultDict;
            resultDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                               options:NSJSONReadingMutableContainers
                                                                                 error:nil];
           success(resultDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    

    

}


- (void)refreshTokenWithRefresh_token:(NSString *)refresh_token
                     Success:(Success)success
                     failure:(Failure)failure{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    
    
    NSString *postUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=wx205bbc61e9b9067b&grant_type=refresh_token&refresh_token=%@",refresh_token];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:postUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resultDict;
        resultDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
        success(resultDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
}


- (void)getUserInfoWithAccess_token:(NSString *)access_token
                          andOpenid:(NSString *)openid
           Success:(Success)success
           failure:(Failure)failure{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    
    
    NSString *postUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?appid=wx205bbc61e9b9067b&access_token=%@&openid=%@",access_token,openid];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:postUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resultDict;
        resultDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
        success(resultDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
}



- (NSString *)getCurrentTimeString{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];//转为字符型
    NSString *tenTime = [timeString substringWithRange:NSMakeRange(0,10)];
    return tenTime;
}



@end
