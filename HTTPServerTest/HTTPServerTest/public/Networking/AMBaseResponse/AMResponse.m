//
//  AMResponse.m
//  AMen
//
//  Created by 曾宏亮 on 15/10/30.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import "AMResponse.h"

@implementation AMResponse

-(BOOL) isSucceed{
    return self.statusCode==1;
}

@end
