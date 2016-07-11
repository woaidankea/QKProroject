//
//  AMRequestHelper.h
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define BASE_URL @"http://120.26.14.165:8881/amen"
#define BASE_URL @"http://api.aimodou.net"

@interface AMRequestHelper : NSObject


+ (void)requestAFURL:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))complectionBlock
               error:(void(^)(NSError *error))errorBlock;

+(id)resultData :(id)result requestActionBody:(NSString *)actionBody;


+(void)startRequest:(NSMutableDictionary *)actionInfo
          success:(void(^)(id result)) successCallback
           failure:(void(^)(NSInteger errorCode, NSString *errorMessage)) errorCallback;

@end
