//
//  MusicViewController.m
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "MusicViewController.h"

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
#import "UITableViewCell+FlatUI.h"

#import "AppDelegate.h"

@interface MusicViewController ()

@end

@implementation MusicViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] isMusicPlaying]){
        [self.ui_button_musicswitch setTitle:@"Pause" forState:UIControlStateNormal];
    } else {
        [self.ui_button_musicswitch setTitle:@"Play" forState:UIControlStateNormal];
    }
    
    
    [self decorateUI];
}

-(void)playMusic{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playMusic];
}
-(void)pauseMusic{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] pauseMusic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionMucic:(id)sender {
    
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] isMusicPlaying]){
        [self.ui_button_musicswitch setTitle:@"Play" forState:UIControlStateNormal];
        [self pauseMusic];
    }
    else {
        [self.ui_button_musicswitch setTitle:@"Pause" forState:UIControlStateNormal];
        [self playMusic];
    }
}

-(void)decorateUI{
    //View
    [self.view setBackgroundColor:[UIColor colorFromHexCode:@"e0e0d8"]];
    
    //Navagion Bar
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor wetAsphaltColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18], UITextAttributeTextColor: [UIColor whiteColor]};
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor peterRiverColor]];
    
    // Dismiss Bar Button Item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(gotoDismiss)];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    [self.navigationItem.rightBarButtonItem configureFlatButtonWithColor:[UIColor wetAsphaltColor] highlightedColor:[UIColor belizeHoleColor] cornerRadius:3];
    
    self.ui_button_musicswitch.buttonColor = [UIColor peterRiverColor];
    self.ui_button_musicswitch.shadowColor = [UIColor belizeHoleColor];
    self.ui_button_musicswitch.shadowHeight = 3.0f;
    self.ui_button_musicswitch.cornerRadius = 6.0f;
    self.ui_button_musicswitch.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.ui_button_musicswitch setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.ui_button_musicswitch setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
}

- (void)gotoDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
