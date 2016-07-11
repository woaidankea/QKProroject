//
//  AMRequestHelper.m
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMRequestHelper.h"
#import "AFNetworking.h"
#import "AMHTTPRequestSerializer.h"
//#import "AMLocationInfo.h"
//#import "AMSystemInfo.h"
//#import "AMAppInfo.h"
//#import "AMMergeHttpParams.h"






@implementation AMRequestHelper
+ (void)requestAFURL:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))complectionBlock
               error:(void(^)(NSError *error))errorBlock {
    urlstring = [BASE_URL stringByAppendingString:urlstring];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//     manager.requestSerializer.timeoutInterval=10.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"image/png",@"image/jpg",@"image/jpeg",@"image/gif",@"image/pjpeg",@"image/jpge",@"application/json",nil]];
   

    if ([method isEqualToString:@"GET"]) {
        [manager GET:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            complectionBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
        }];
    }
    else if([method isEqualToString:@"POST"]) {
        
        if (datas != nil) { //判断是否有文件需要上传
            
            //上传文件的POST请求
            AFHTTPRequestOperation *operation = [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                //将需要上传的文件数据添加到formData
                
                //循环遍历需要上的文件数据
                for (NSString *name in datas) {
                    NSData *data = datas[name];
                    
                    [formData appendPartWithFileData:data name:name fileName:name mimeType:@"image/jpeg"];
                    
                }
                
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                complectionBlock(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                errorBlock(error);
            }];
            
            //设置上传的进度监听
            /**
             *
             *  @param bytesWritten              一个数据包的大小
             *  @param totalBytesWritten         已经上传的数据大小
             *  @param totalBytesExpectedToWrite 文件总大小
             *
             */
//            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//                
//                CGFloat progress = totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
//                NSLog(@"进度：%.1f",progress);
//                
//            }];
            
        } else {
            [manager POST:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                complectionBlock(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                errorBlock(error);
            }];
        }
    }
}
+(id)resultData :(id)result requestActionBody:(NSString *)actionBody{
    id ret = [result objectForKey:actionBody];
    return ret;
}


//+(void)startRequest:(NSMutableDictionary *)actionInfo
//            success:(void(^)(id result)) successCallback
//            failure:(void(^)(NSInteger errorCode, NSString *errorMessage)) errorCallback{
//    ///TODO:需要根据位置更新
//    NSMutableDictionary *locationInfo =[AMLocationInfo locationInfoData:@"北京" longitude:@"" latitude:@"" address:@"上海"];
//    NSMutableDictionary *sysytemInfo =[AMSystemInfo systemInfoData];
//    NSMutableDictionary *appInfo =[AMAppInfo appInfoData];
//    NSMutableDictionary *paramsDictory =[AMMergeHttpParams httpMerageParams:locationInfo systemInfo:sysytemInfo appInfo:appInfo actionInfo:actionInfo];
//    [self requestAFURL:@"" httpMethod:@"POST" params:paramsDictory data:nil complection:^(id result) {
//        NSInteger returnCode=[[result objectForKey:@"code"] integerValue];
//        if(returnCode==1){
//            if(successCallback!=nil){
//                successCallback(result);
//            }
//        }else{
//            if(errorCallback!=nil){
//                NSString *message=(NSString *)[result objectForKey:@"message"];
//                errorCallback(returnCode, message);
//            }
//        }
//        
//    } error:^(NSError *error) {
//        if(errorCallback!=nil){
//            NSString *message= error.localizedDescription;
//            errorCallback(error.code, message);
//        }
//    }];
//    
//    
//}
//



@end
