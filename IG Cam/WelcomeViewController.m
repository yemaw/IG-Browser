//
//  WelcomeViewController.m
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIPopoverController+FlatUI.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor peterRiverColor]];
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor peterRiverColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
