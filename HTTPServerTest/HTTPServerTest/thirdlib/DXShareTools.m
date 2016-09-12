//
//  DXShareTools.m
//  MDApplication
//
//  Created by jieku on 16/3/29.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "DXShareTools.h"
#import <ShareSDK/ShareSDK.h>
#define CGMMainScreenWidth            ([[UIScreen mainScreen] bounds].size.width)
#define CGMMainScreenHeight           ([[UIScreen mainScreen] bounds].size.height)

#import "AppDelegate.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"


@interface DXShareTools()

@end
@implementation ShareModel


@end



@implementation DXShareTools


static DXShareTools *_shareTools = nil;
+(DXShareTools *)shareToolsInstance
{
    if (_shareTools == nil)
    {
        _shareTools = [[DXShareTools alloc] init];
        
    }
    return _shareTools;
}
- (id)init{
    self = [super init];
   
    return  self;
}
////分享到
- (void)ShareWithModel:(ShareModel *)model andType:(ShareType) shareType {
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    if(shareType == TypeQQ){
     type = SSDKPlatformSubTypeQQFriend;
    }
    if(shareType == TypeQZone){
         type = SSDKPlatformSubTypeQZone;
    }
    if(shareType == TypeWeChat){
        type = SSDKPlatformSubTypeWechatSession;
    }
    if(shareType == TypeDiscover){
        type = SSDKPlatformSubTypeWechatTimeline;
        
    }
    
    if(shareType == TypeSinaWeibo){
        type = SSDKPlatformTypeSinaWeibo;
        
    }

    
    
  
    
    [shareParams SSDKSetupShareParamsByText:model.desc
                                     images:model.imageArray //传入要分享的图片
                                        url:[NSURL URLWithString:model.url]
                                      title:model.title
                                       type:SSDKContentTypeWebPage];
    
    
    [shareParams SSDKEnableUseClientShare];

    
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                      message:nil
                                                                                     delegate:self
                                                                            cancelButtonTitle:@"确定"
                                                                            otherButtonTitles:nil];
                                  [alertView show];

             }
             case SSDKResponseStateFail:
             {
                 if([error.domain isEqualToString:@"ShareSDKErrorDomain"]){
                     
                     
                     if(type == SSDKPlatformSubTypeQQFriend ||type == SSDKPlatformSubTypeQZone){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装QQ客户端"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                         
                         
                     }
                     if(type == SSDKPlatformTypeSinaWeibo){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装新浪客户端"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                     }
                     if(type == SSDKPlatformSubTypeWechatSession || type == SSDKPlatformSubTypeWechatTimeline){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装微信客户端"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                     }
                     
                     
                     
                 }
                 break;
             }
                 
             case SSDKResponseStateCancel: {
                 //                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消分享"
                 //                                                                 message:nil
                 //                                                                delegate:self
                 //                                                       cancelButtonTitle:@"OK"
                 //                                                       otherButtonTitles:nil, nil];
                 //                 [alert show];
                 break;
                 
             }
                 
             default:
                 break;
         }
         
         // 回调处理....
     }];
    
    
}



@end

