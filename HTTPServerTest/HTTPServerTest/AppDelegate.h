//
//  AppDelegate.h
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTTPServer;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
HTTPServer *httpServer;
}
@property (strong, nonatomic) UIWindow *window;


@end

