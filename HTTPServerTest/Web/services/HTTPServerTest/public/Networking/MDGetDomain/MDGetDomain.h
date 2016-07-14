//
//  MDGetDomain.h
//  MDApplication
//
//  Created by jieku on 16/4/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDGetDomain : AMBaseRequest
-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed;
@end
