//
//  LoginWebViewController.m
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "LoginWebViewController.h"

@interface LoginWebViewController ()

@end

@implementation LoginWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.ui_webview_instagram_login loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", @"https://api.instagram.com/oauth/authorize/?client_id=6c6980e35d814d5587cb76b0b5cb32bd&redirect_uri=ig6c6980e35d814d5587cb76b0b5cb32bd://authorize&response_type=token"]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
