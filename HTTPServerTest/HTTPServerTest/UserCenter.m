//
//  UserCenter.m
//  ChengGuan
//
//  Created by 胡家生 on 16/8/18.
//  Copyright © 2016年 ouzukeji. All rights reserved.
//

#import "UserCenter.h"

#pragma mark ----------------------------- login keyChain

#define kAccess_tokenKey @"access_token"
#define kExpires_inKey @"expires_in"
#define kRefresh_tokenKey @"refresh_token"
#define kOpenidKey @"openid"
#define kScopeKey @"scope"

#define kUnionidKey @"unionid"
#define kHeadImageurl @"headimageurl"
#define kNickName    @"nickname"


@implementation UserCenter


- (void)dealloc {
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        
    }
    
    return self;
}

- (void)clearUserInfo{
    
    self.access_token = nil;
    self.expires_in = nil;
    self.refresh_token = nil;
    self.openid = nil;
    self.scope = nil;
    self.unionid = nil;
  
    
   
    //dx create
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kAccess_tokenKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kExpires_inKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kRefresh_tokenKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kOpenidKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kScopeKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUnionidKey];
   
    
}

- (void)markAsLogout
{
    [self clearUserInfo];
}


#pragma mark Singleton methods
#pragma mark 单例方法

static UserCenter *defaultUserCenter = nil;

+ (UserCenter *)defaultCenter
{
    @synchronized(self){
        if (defaultUserCenter == nil) {
            defaultUserCenter = [[UserCenter alloc] init];
        }
    }
    return defaultUserCenter;
}



-(void)saveUserInfoDict:(NSDictionary *)dict
{
    

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [SNUserDefault setObject:dict[@"access_token"] forKey:kAccess_tokenKey];
    [SNUserDefault setObject:dict[@"expires_in"] forKey:kExpires_inKey];
    [SNUserDefault setObject:dict[@"refresh_token"] forKey:kRefresh_tokenKey];
    [SNUserDefault setObject:dict[@"openid"] forKey:kOpenidKey];
    [SNUserDefault setObject:dict[@"scope"] forKey:kScopeKey];
    [SNUserDefault setObject:dict[@"unionid"] forKey:kUnionidKey];
    
    
    
    [def synchronize];
}

- (void)setheadimageUrl:(NSString *)url{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:url forKey:kHeadImageurl];
    [def synchronize];
   
}
- (void)setnickName:(NSString *)name{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:name forKey:kNickName];
    [def synchronize];


}


- (NSString *)getnickname{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *nickname = [def objectForKey:kNickName];
    return nickname;

}

- (NSString *)getheadimageurl{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *headimageurl = [def objectForKey:kHeadImageurl];
    return headimageurl;
    
}


- (NSString *)access_token{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [def objectForKey:@"access_token"];
    return access_token;
}

- (NSString *)open_id{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [def objectForKey:@"openid"];
    return access_token;
}

- (NSString *)unionid{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *unionid = [def objectForKey:kUnionidKey];
    return unionid;
}

- (NSString *)refresh_token{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *refresh_token = [def objectForKey:kRefresh_tokenKey];
    return refresh_token;
}

@end
