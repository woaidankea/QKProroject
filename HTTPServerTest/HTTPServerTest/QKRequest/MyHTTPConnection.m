#import "MyHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"
#import "MDGetDomain.h"
#import <AFNetworking.h>

#import <AFHTTPRequestOperationManager+Synchronous.h>
// Log levels : off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN; // | HTTP_LOG_FLAG_TRACE;


/**
 * All we have to do is override appropriate methods in HTTPConnection.
**/

@implementation MyHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
	HTTPLogTrace();
	
	// Add support for POST
	
//	if ([method isEqualToString:@"POST"])
//	{
//		if ([path isEqualToString:@"/post.html"])
//		{
//			// Let's be extra cautious, and make sure the upload isn't 5 gigs
//			
//			return requestContentLength < 50;
//		}
//	}
	
	return [super supportsMethod:method atPath:path];
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
	HTTPLogTrace();
	
	// Inform HTTP server that we expect a body to accompany a POST request
	
	if([method isEqualToString:@"POST"])
		return YES;
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}
- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	HTTPLogTrace();
    
    NSLog(@"path=%@",path);
	
    if ([method isEqualToString:@"GET"] && [path isEqualToString:@"/services/users.getInfo"])
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://127.0.0.1:7777/qianxiu.mobileconfig"]];
        
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        // Result will be of the form "answer=..."
        
        //		int answer = [[postStr substringFromIndex:7] intValue];
        
        //		NSData *response = nil;
        //		if(answer == 10)
        //		{
        //			response = [@"<html><body>Correct<body></html>" dataUsingEncoding:NSUTF8StringEncoding];
        //		}
        //		else
        //		{
        //			response = [@"<html><body>Sorry - Try Again<body></html>" dataUsingEncoding:NSUTF8StringEncoding];
        //		}
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSError *error = nil;
        id request1 = [manager syncGET:@"http://h.51tangdou.com/weizuan/"
                            parameters:@{
                                         @"a":@"getdomain",
                                         @"m":@"tudi"
                                         }
                             operation:NULL
                                 error:&error];
        
        
        
        
        
        
        
        
        return [[HTTPDataResponse alloc] initWithData:request1];
    }

    if ([method isEqualToString:@"GET"] && [path isEqualToString:@"/services/users.getInfo"])
    {
        
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://127.0.0.1:7777/embedded.mobileconfig"]];
        
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
 
//        
//        NSString *postStr = nil;
//        
//        NSData *postData = [request body];
//        if (postData)
//        {
//            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
//        }
//        
//        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
//        
//        // Result will be of the form "answer=..."
//        
//        //		int answer = [[postStr substringFromIndex:7] intValue];
//        
//        //		NSData *response = nil;
//        //		if(answer == 10)
//        //		{
//        //			response = [@"<html><body>Correct<body></html>" dataUsingEncoding:NSUTF8StringEncoding];
//        //		}
//        //		else
//        //		{
//        //			response = [@"<html><body>Sorry - Try Again<body></html>" dataUsingEncoding:NSUTF8StringEncoding];
//        //		}
//        
//        
//        
//        
//        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSError *error = nil;
//        id request1 = [manager syncGET:@"http://h.51tangdou.com/weizuan/"
//                            parameters:@{
//                                         @"a":@"getdomain",
//                                         @"m":@"tudi"
//                                         }
//                             operation:NULL
//                                 error:&error];
//        
//        
//        
//        
//        
//        
//        
//        
//        return [[HTTPDataResponse alloc] initWithData:request1];
    }
    
  
    
	if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kGetUser])
	{
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
		
		NSString *postStr = nil;
		
		NSData *postData = [request body];
		if (postData)
		{
			postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
		}
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
		
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
//        NSDictionary *headerDict = [QKDevice systemInfoData];
//                
//        if(headerDict!=nil){
//            [headerDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
//            }];
//        }
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"u"]];

        NSError *error = nil;
        
        NSLog(@"requestBefore");
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kGetUser]
                                parameters:parameters
                                            operation:NULL
                                    error:&error];
        NSData *reponse = request1;
        NSLog(@"requestAfter");
        
 		return [[HTTPDataResponse alloc] initWithData:reponse];
	}
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kSystemConfig])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
            
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"app_label"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kSystemConfig]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kKeyState])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        //        NSDictionary *headerDict = [QKDevice systemInfoData];
        //
        //        if(headerDict!=nil){
        //            [headerDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //                [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        //            }];
        //        }
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kKeyState]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kGetMenu])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
   
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kGetMenu]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kGetUserBalance])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"userid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kGetUserBalance]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kTaskStatus])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"taskid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kTaskStatus]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }

    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kTudiList])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"userid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kTudiList]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kTaskInfo])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"taskid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kTaskInfo]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }

    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kIncomeList])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"userid",@"type"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kIncomeList]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kAcceptTask])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"taskid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kAcceptTask]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kTaskList])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"userid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kTaskList]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kUserInfo])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"userid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kUserInfo]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kPhoneBdUser])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"phonenum",@"phonecode"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kPhoneBdUser]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kPhoneBdUser])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"phone"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kUserInfo]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kPhoneGetCode])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"phone"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kPhoneGetCode]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }

    
    //获取收徒链接
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kStLink])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kStLink]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    //更新用户资料
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kupUserInfo])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"birthday",@"userid",@"sex",@"vocation"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kupUserInfo]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }

    
    //手机充值
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kCashApplyPhone])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"phonenum",@"applymoney"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kCashApplyPhone]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    //提现阿里
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kCashApplyAl])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"aliaccount",@"aliname",@"applymoney"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kCashApplyAl]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    


    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kGiveupTask])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"taskid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kGiveupTask]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kCopyString])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        NSString *keyword = [HttpTools getValueWithPath:path andKey:@"value"];
        
        NSLog(@"keyWord = %@",[keyword stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [keyword stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *reponse = [@"{\"code\": 0}" dataUsingEncoding:NSASCIIStringEncoding];        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    

    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kGetHeader])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"taskid"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",@"http://60.173.8.147",kGetHeader]
                            parameters:nil
                       
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/services/saveimage"])
    {
        
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://127.0.0.1:8888/embedded.mobileconfig"]];
        
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        
      
        NSString *string =[[postStr componentsSeparatedByString:@"url="] objectAtIndex:1];
        NSLog(@"%@[%p]: postStr: %@", THIS_FILE, self, string);
        NSString *imageString = [[string componentsSeparatedByString:@","] objectAtIndex:1];
        NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:imageString];
        
        UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
        
        NSLog(@"===Decoded image size: %@", NSStringFromCGSize(_decodedImage.size));
        
        UIImageWriteToSavedPhotosAlbum(_decodedImage, self, nil, NULL);
        
        
        NSData *reponse = [@"{\"code\": 0}" dataUsingEncoding:NSASCIIStringEncoding];
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kChengji])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kChengji]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    
    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kQhCode])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"phone"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kQhCode]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }

    if ([method isEqualToString:@"GET"] && [[HttpTools separatedUrl:path] isEqualToString:kswitchUser])
    {
        HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
        
        NSString *postStr = nil;
        
        NSData *postData = [request body];
        if (postData)
        {
            postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        }
        HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer =  [[AFJSONResponseSerializer alloc] init];
        
        
        
        [HttpTools setHttpmanagerHeader:manager];
        
        NSDictionary *parameters = [HttpTools getParamsWithUrl:path and:@[@"phonecode",@"phonenum"]];
        
        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kQXServerUrl,kswitchUser]
                            parameters:parameters
                             operation:NULL
                                 error:&error];
        NSData *reponse = request1;
        
        return [[HTTPDataResponse alloc] initWithData:reponse];
    }
    


	return [super httpResponseForMethod:method URI:path];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength
{
	HTTPLogTrace();
	
	// If we supported large uploads,
	// we might use this method to create/open files, allocate memory, etc.
}

- (void)processBodyData:(NSData *)postDataChunk
{
	HTTPLogTrace();
	
	// Remember: In order to support LARGE POST uploads, the data is read in chunks.
	// This prevents a 50 MB upload from being stored in RAM.
	// The size of the chunks are limited by the POST_CHUNKSIZE definition.
	// Therefore, this method may be called multiple times for the same POST request.
	
	BOOL result = [request appendData:postDataChunk];
	if (!result)
	{
		HTTPLogError(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
	}
}

@end
