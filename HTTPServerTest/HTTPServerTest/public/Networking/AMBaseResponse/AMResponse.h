//
//  AMResponse.h
//  AMen
//
//  Created by 曾宏亮 on 15/10/30.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMResponse : NSObject

@property (nonatomic, assign)int statusCode;

@property (strong, nonatomic) NSString *errorMessage;
@property (nonatomic, copy) NSString *message;

@property (strong, nonatomic) id data;

@property (nonatomic, assign) int actionId;

-(BOOL) isSucceed;

@end
