//
//  MDInterestDetailViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
#import "DXShareTools.h"
#import <WebKit/WebKit.h>
#import "YPWebView.h"
@interface MDInterestDetailViewController : BaseViewController

@property (nonatomic,strong)ShareModel *model;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong,nonatomic)YPWebView *wkwebview;
@property (nonatomic,strong)UIImage *shareImage;

- (IBAction)shareButtonClick:(id)sender;

@end
