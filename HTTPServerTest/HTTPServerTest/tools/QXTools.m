//
//  QXTools.m
//  HTTPServerTest
//
//  Created by jieku on 16/8/22.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "QXTools.h"

@implementation QXTools
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

+ (BOOL)isJailBreak
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
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
