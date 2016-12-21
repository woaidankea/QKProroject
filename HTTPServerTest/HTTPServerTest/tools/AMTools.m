//
//  AMTools.m
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMTools.h"


@implementation AMTools

static const NSUInteger MAX_SIZE=1024*300ul;

+ (id)getLocalJsonDataWithFileName:(NSString *)fileName{
    NSError*error;
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"txt"];
    
    //根据文件路径读取数据
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    
    //格式化成json数据
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    
    return jsonObject;
}

+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch([reachability currentReachabilityStatus]){
        case NotReachable: isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN: isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi: isExistenceNetwork = TRUE;
            break;
    }
    return isExistenceNetwork;
}


+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:nil];
    [alertView show];
}


@end
