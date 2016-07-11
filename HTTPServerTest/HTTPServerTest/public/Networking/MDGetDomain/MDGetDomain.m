//
//  MDGetDomain.m
//  MDApplication
//
//  Created by jieku on 16/4/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDGetDomain.h"

@implementation MDGetDomain
-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed{
    self=[super initWithSuccessCallback:success failureCallback:failed];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
            [dict setObject:@"tudi" forKey:@"m"];
            [dict setObject:@"getdomain" forKey:@"a"];
        
        [self setActionInfo:dict];
    }
    return self;
    
}

- (NSString *)getMethod {
    return @"GET";
}


- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
//        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
//        self.responseObject =  dic;
    }
}

@end
