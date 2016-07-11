//
//  AMHTTPRequestSerializer.m
//  AMen
//
//  Created by Draco Wang on 15-8-17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMHTTPRequestSerializer.h"
#import "MDPublicConfig.h"

@implementation AMHTTPRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSURLRequest *serializedRequest = [super requestBySerializingRequest:request withParameters:nil
                                                                   error:error];
    NSMutableURLRequest *mutableRequest = [serializedRequest mutableCopy];

    [mutableRequest setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    
//    long UserId =[[NSUSERDEFAULIT objectForKey:AM_USER_UID]longLongValue];
    

#warning header 参数需要修改取值
    int64_t userId = [[NSUSERDEFAULIT objectForKey:AM_USER_ACCOUNTID]longLongValue];
    int32_t version = 100;
    int64_t reserve = 0;
    
    NTOHLL(userId);
    NTOHL(version);
    NTOHLL(reserve);

    NSMutableData *postData = [NSMutableData data];
    [postData appendBytes:&userId length:sizeof(int64_t)];  // 0 - 7 userId
    [postData appendBytes:&version length:sizeof(int32_t)]; // 8 - 11 version
    [postData appendBytes:&reserve length:sizeof(int64_t)]; // 12 - 19 lang
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    [postData appendData:data];

    [mutableRequest setHTTPBody:postData];
    
    return mutableRequest;
}

@end
