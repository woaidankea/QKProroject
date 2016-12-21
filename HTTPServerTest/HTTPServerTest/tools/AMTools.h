//
//  AMTools.h
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface AMTools : NSObject 



+ (id)getLocalJsonDataWithFileName:(NSString *)fileName;
+ (BOOL)isExistenceNetwork;
#pragma mark - AlertView -
+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel;
@end
