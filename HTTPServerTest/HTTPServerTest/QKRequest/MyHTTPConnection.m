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
	
	if ([method isEqualToString:@"POST"])
	{
		if ([path isEqualToString:@"/post.html"])
		{
			// Let's be extra cautious, and make sure the upload isn't 5 gigs
			
			return requestContentLength < 50;
		}
	}
	
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
-(NSString *) jiexi:(NSString *)CS webaddress:(NSString *)webaddress
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
        //NSRange matchRange = [match range];
        //NSString *tagString = [webaddress substringWithRange:matchRange];  // 整个匹配串
        //        NSRange r1 = [match rangeAtIndex:1];
        //        if (!NSEqualRanges(r1, NSMakeRange(NSNotFound, 0))) {    // 由时分组1可能没有找到相应的匹配，用这种办法来判断
        //            //NSString *tagName = [webaddress substringWithRange:r1];  // 分组1所对应的串
        //            return @"";
        //        }
        
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        //    NSLog(@"分组2所对应的串:%@\n",tagValue);
        return tagValue;
    }
    return @"";
}
- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	HTTPLogTrace();
	NSArray *array = [path componentsSeparatedByString:@"?"];
    NSString *url;
    if(array.count>0){
        url= array[0];
    }
	if ([method isEqualToString:@"GET"] && [url isEqualToString:kGetUser])
	{
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://127.0.0.1:8888/embedded.mobileconfig"]];
        
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
        
        NSDictionary *headerDict = [QKDevice systemInfoData];
                
        if(headerDict!=nil){
            [headerDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }
        NSMutableDictionary *parameters = [NSMutableDictionary new];
       
         [parameters setValue: POST_VALUE([self jiexi:@"do_create" webaddress:path]) forKey:@"do_create"];
         [parameters setValue: POST_VALUE([self jiexi:@"time" webaddress:path]) forKey:@"time"];
         [parameters setValue: POST_VALUE([self jiexi:@"sign" webaddress:path]) forKey:@"sign"];
        
        

        NSError *error = nil;
        id request1 = [manager syncGET:[NSString stringWithFormat:@"%@%@",kServerUrl,kGetUser]
                                parameters:parameters
                                            operation:NULL
                                    error:&error];
            
            
            
//       NSDictionary *result = [[MMTService shareInstance]syncgetAppCol];
        

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
