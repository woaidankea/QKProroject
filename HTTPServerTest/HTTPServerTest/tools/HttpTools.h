//
//  HttpTools.h
//  HTTPServerTest
//
//  Created by jieku on 16/7/14.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFHTTPRequestOperationManager+Synchronous.h>
@interface HttpTools : NSObject
+ (NSString *) jiexi:(NSString *)CS webaddress:(NSString *)webaddress;

+ (NSString *)separatedUrl:(NSString *)url;


+ (NSDictionary *)getParamsWithUrl:(NSString *)path and:(NSArray *) paramsKey;

+ (void)setHttpmanagerHeader:(AFHTTPRequestOperationManager *)manager;

+ (NSString *)getValueWithPath:(NSString *)path andKey:(NSString *)key;


@end
