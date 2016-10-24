//
//  UserCenter.h
//  ChengGuan
//
//  Created by 胡家生 on 16/8/18.
//  Copyright © 2016年 ouzukeji. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SNUserDefault [NSUserDefaults standardUserDefaults]

@interface UserCenter : NSObject

@property (nonatomic,strong) NSString *access_token;//d_role

@property (nonatomic,strong) NSString *expires_in;

@property (nonatomic,strong) NSDate   *refresh_token;

@property (nonatomic,strong) NSString *openid;

@property (nonatomic,strong) NSDate   *scope;

@property (nonatomic,strong) NSString *unionid;

+ (UserCenter *)defaultCenter;

- (void)clearUserInfo;
- (void)markAsLogout;
- (void)saveUserInfoDict:(NSDictionary *)dict;
- (void)setheadimageUrl:(NSString *)url;
- (void)setnickName:(NSString *)name;

- (NSString *)open_id;

- (NSString *)access_token;

- (NSString *)refresh_token;

- (NSString *)getnickname;

- (NSString *)getheadimageurl;

- (NSString *)unionid;

@end
