//
//  HttpTools.m
//  HTTPServerTest
//
//  Created by jieku on 16/7/14.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "HttpTools.h"

@implementation HttpTools
+ (NSString *) jiexi:(NSString *)CS webaddress:(NSString *)webaddress
{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    // NSString *webaddress=@"http://www.baidu.com/dd/adb.htm?adc=e12&xx=lkw&dalsjd=12";
    NSArray *matches = [regex matchesInString:webaddress
                                      options:0
                                        range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        
        return tagValue;
    }
    return @"";
}
+ (NSString *)separatedUrl:(NSString *)url{
    NSArray *array = [url componentsSeparatedByString:@"?"];
    NSString *path;
    if(array.count>0){
        path= array[0];
    }
    
    return path;
}

+ (NSDictionary *)getParamsWithUrl:(NSString *)path and:(NSArray *) paramsKey{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    for(NSString * paramKey in paramsKey){
        if([[self jiexi:paramKey webaddress:path] isEqualToString:@"null"]){
         [parameters setValue: POST_VALUE(@"") forKey:paramKey];
        }else{
        
      [parameters setValue: POST_VALUE([self jiexi:paramKey webaddress:path]) forKey:paramKey];
        }
    }
    
    
//    [parameters setValue: POST_VALUE([self jiexi:@"do_create" webaddress:path]) forKey:@"do_create"];
    [parameters setValue: POST_VALUE([self jiexi:@"time" webaddress:path]) forKey:@"time"];
    [parameters setValue: POST_VALUE([self jiexi:@"sign" webaddress:path]) forKey:@"sign"];
    return parameters;
}

+ (NSString *)getValueWithPath:(NSString *)path andKey:(NSString *)key{

//    NSString* encodedString = ;
    return  POST_VALUE([self jiexi:key webaddress:path]);
}
+ (void)setHttpmanagerHeader:(AFHTTPRequestOperationManager *)manager{
    NSDictionary *headerDict = [QKDevice systemInfoData];
    
    if(headerDict!=nil){
        [headerDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

}
@end
