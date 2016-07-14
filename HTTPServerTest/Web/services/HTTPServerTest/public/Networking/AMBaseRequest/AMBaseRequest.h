//
//  AMBaseRequest.h
//  AMen
//
//  Created by 曾宏亮 on 15/10/30.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMBaseResponse.h"

static NSString *action_Id = @"actionId";

//static NSString * const BaseAddress =@"http://verifyapp.amenba.com/amen";

//if Jieku 服务器

static NSString * const BaseAddress =@"http://h.51tangdou.com/weizuan";
//else

//static NSString * const BaseAddress =@"http://api.aizhuanfa.net";




@interface AMBaseRequest : NSObject

@property (nonatomic, strong) AMBaseResponse *response;
@property (nonatomic, strong) id responseObject;

typedef void(^onSuccessCallback)(AMBaseRequest* request);
typedef void(^onFailureCallback)(AMBaseRequest* request);

-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed;

-(NSString*)getMethod;

-(NSString*)getURL;

-(void)processResponse:(NSDictionary *)responseDictionary;

-(void)setActionInfo:(NSDictionary *)actionInfo;

-(void)start;

-(onFailureCallback)failCallback;

@end
