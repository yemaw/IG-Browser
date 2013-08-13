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
        UIImage* music_img = [UIImage imageNamed:@"play_btn"];
        CGRect frame_img1 = CGRectMake(0, 0, 40, 20);
        UIButton *music_btn = [[UIButton alloc] initWithFrame:frame_img1];
        [music_btn setBackgroundImage:music_img forState:UIControlStateNormal];
        
        [music_btn addTarget:self action:@selector(actionMucic:)
            forControlEvents:UIControlEventTouchUpInside];
        [music_btn setShowsTouchWhenHighlighted:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:music_btn];
        
        //[self.ui_button_musicswitch setTitle:@"Play" forState:UIControlStateNormal];
        [self pauseMusic];
    }
    else {
        UIImage* music_img = [UIImage imageNamed:@"pause_btn"];
        CGRect frame_img1 = CGRectMake(0, 0, 40, 20);
        UIButton *music_btn = [[UIButton alloc] initWithFrame:frame_img1];
        [music_btn setBackgroundImage:music_img forState:UIControlStateNormal];
        [music_btn addTarget:self action:@selector(actionMucic:)
            forControlEvents:UIControlEventTouchUpInside];
        [music_btn setShowsTouchWhenHighlighted:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:music_btn];
        
        //[self.ui_button_musicswitch setTitle:@"Pause" forState:UIControlStateNormal];
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
    
    
    // Music Bar Button Item
    UIImage* music_img = [UIImage imageNamed:@"play_btn"];
    CGRect frame_img1 = CGRectMake(0, 0, 40, 20);
    UIButton *music_btn = [[UIButton alloc] initWithFrame:frame_img1];
    [music_btn setBackgroundImage:music_img forState:UIControlStateNormal];
    [music_btn addTarget:self action:@selector(actionMucic:)
        forControlEvents:UIControlEventTouchUpInside];
    [music_btn setShowsTouchWhenHighlighted:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:music_btn];
    
    self.ui_button_camera.buttonColor = [UIColor peterRiverColor];
    self.ui_button_camera.shadowColor = [UIColor belizeHoleColor];
    self.ui_button_camera.shadowHeight = 3.0f;
    self.ui_button_camera.cornerRadius = 6.0f;
    self.ui_button_camera.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.ui_button_camera setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.ui_button_camera setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.ui_button_library.buttonColor = [UIColor peterRiverColor];
    self.ui_button_library.shadowColor = [UIColor belizeHoleColor];
    self.ui_button_library.shadowHeight = 3.0f;
    self.ui_button_library.cornerRadius = 6.0f;
    self.ui_button_library.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.ui_button_library setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.ui_button_library setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
}

- (void)gotoDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getPhotoFromCamera:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;

	picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)getPhotoFromLibrary:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;

    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

	[self presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    PhotoUploadViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoUploadViewControllerStoryBoardID"];
    controller.photo = image;
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
