//
//  ViewController.m
//  HTTPServerTest
//
//  Created by jieku on 16/4/18.
//  Copyright © 2016年 董宪. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    NSURL *url =[NSURL URLWithString:@"http://127.0.0.1:7777/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
  
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
