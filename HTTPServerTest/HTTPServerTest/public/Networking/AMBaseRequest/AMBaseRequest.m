//
//  AMBaseRequest.m
//  AMen
//
//  Created by 曾宏亮 on 15/10/30.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import "AMBaseRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "AMHTTPRequestSerializer.h"
//#import "AMSystemInfo.h"
//#import "AMLocationInfo.h"
//#import "AMAppInfo.h"
//#import "UtilsMacro.h"
#import "AppDelegate.h"

@interface AMBaseRequest (){
    onSuccessCallback _onSuccess;
    onFailureCallback _onFailure;
    NSMutableDictionary * _parameters;
    NSDictionary * _headers;
    
}

@end

@implementation AMBaseRequest

-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed{
    self=[super init];
    if(self){
        _onSuccess=success;
        _onFailure=failed;
       
    }
    return self;
}


-(NSString*) getURL{
    return @"";
}


-(NSString*)getMethod{
    return @"POST";
}

-(onFailureCallback)failCallback{
    return _onFailure;
}

-(void)setActionInfo:(NSDictionary *)actionInfo{
    
//    NSDictionary *info = [AMSystemInfo systemInfoData];
//    if(ServerJieKu){
//        if(USER_DEFAULT_KEY(@"token") != nil && ((NSString *)USER_DEFAULT_KEY(@"token")).length != 0 )
//        [actionInfo setValue: USER_DEFAULT_KEY(@"token") forKey:@"token"];
//      }else {
//          [actionInfo setValue:@"9.2" forKey:@"OSVersion"];  //真机时修改
//          [actionInfo setValue:@"100" forKey:@"dtu"];
//          [actionInfo setValue:[info objectForKey:@"imei"] forKey:@"deviceCode"];
//          [actionInfo setValue: USER_DEFAULT_KEY(@"token") forKey:@"token"];
//
//    }
    
    _parameters=[NSMutableDictionary dictionaryWithDictionary:actionInfo];
//    NSDictionary *locationInfo =[AMLocationInfo locationInfo];
//    NSDictionary *systemInfo =[AMSystemInfo systemInfoData];
//    NSDictionary *appInfo =[AMAppInfo appInfoData];
//    [_parameters setObject:locationInfo forKey:@"locationInfo"];
//    [_parameters setObject:systemInfo forKey:@"systemInfo"];
//    [_parameters setObject:appInfo forKey:@"appInfo"];
//    [_parameters setObject:actionInfo forKey:@"actionInfo"];
}

-(void)processResponse:(NSDictionary *)responseDictionary{
    _response=[[AMBaseResponse alloc]init];
    if(responseDictionary!=nil){
        _response.statusCode=[[responseDictionary objectForKey:@"code"] intValue];
        if(_response.statusCode ==-126){
            
//            [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];

        }
        
        
        _response.actionId=[[responseDictionary objectForKey:@"actionId"] intValue];
    }
}


-(void)start{
    NSString* url=[BaseAddress stringByAppendingString:[self getURL]];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.requestSerializer=[AMHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval=10.0f;
    
    if(_headers!=nil){
        [_headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
//    只需要在发送请求前加入:

    manager.responseSerializer=[AFJSONResponseSerializer serializer];
       
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/xml",@"text/plain"]];
    manager.securityPolicy.allowInvalidCertificates=YES;
    
    
    if([[self getMethod] isEqualToString:@"GET"]){
        [self onGet:manager url:url];
    }else if([[self getMethod] isEqualToString:@"POST"]){
        [self onPost:manager url:url];
    }
}

-(void) onGet:(AFHTTPRequestOperationManager *)manager url:(NSString *)url{
    
//    NSMutableDictionary *dict =[NSMutableDictionary new];
//    [dict setObject:@"profit" forKey:@"m"];
//    [dict setObject:@"sharesuc" forKey:@"a"];
//    [dict setObject:@"1" forKey:@"plat"];
//
//    [dict setObject:@"LjCiwe2kNuSzpgpPogqnnJnmoTogIHkuobvvIHlv6vmlLvkuIrnr67ooqvooYDluL3kuIDluZXlpKrlv4PphbgsMTQ2MDYxMjk4Mw" forKey:@"key"];
//    [dict setObject:@"ios" forKey:@"device"];
//    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:_parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//     NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * result=responseObject;
        [self processResponse:responseObject];
        if([_response isSucceed]){
            if(_onSuccess!=nil){
                _onSuccess(self);
            }
        }else{
            if([result[@"message"] isEqualToString:@"Token过期"])
            {
                return;
            }
            [_response setErrorMessage:result[@"message"]];
            if(_onFailure!=nil){
                _onFailure(self);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processError:error];
        if(_onFailure!=nil){
            _onFailure(self);
        }
    }];
}

-(void)onPost:(AFHTTPRequestOperationManager *)manager url:(NSString *)url{
    [manager POST:url parameters:_parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _responseObject = responseObject;
        NSDictionary * result=responseObject;
        [self processResponse:result];
        if([_response isSucceed]){
            if(_onSuccess!=nil){
                _onSuccess(self);
            }
        }else{
            [_response setErrorMessage:result[@"message"]];
            if(_onFailure!=nil){
                _onFailure(self);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processError:error];
        if(_onFailure!=nil){
            _onFailure(self);
        }
    }];
    
}


-(void)processError:(NSError *)error{
    _response=[[AMBaseResponse alloc]init];
    if([error code]==-1001||[error code]==-1009 || [error code]==-1004){
        _response.errorMessage=@"网络不给力!";
        _response.statusCode=-100;
    }else{
        _response.statusCode=(int)error.code;
        _response.errorMessage=error.description;
    }
    
}



@end


