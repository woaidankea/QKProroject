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

- (NSString *)getCurrentTimeString{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];//转为字符型
    NSString *tenTime = [timeString substringWithRange:NSMakeRange(0,10)];
    return tenTime;
}



@end
