//
//  ViewController.h
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIImageView *headImgaView;
@property (weak, nonatomic) IBOutlet UIButton *BeginButton;
@property (weak, nonatomic) IBOutlet UILabel *NickName;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
- (IBAction)btnClick:(UIButton *)sender;

@end

