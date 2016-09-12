//
//  QXTools.h
//  HTTPServerTest
//
//  Created by jieku on 16/8/22.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QXTools : NSObject

+ (BOOL)isJailBreak;
+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel;
@end
