//
//  MusicViewController.h
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>

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

#import "PhotoUploadViewController.h"

@interface MusicViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet FUIButton *ui_button_library;
@property (weak, nonatomic) IBOutlet FUIButton *ui_button_camera;


- (IBAction)actionMucic:(id)sender;

- (IBAction)getPhotoFromCamera:(id)sender;
- (IBAction)getPhotoFromLibrary:(id)sender;

-(void)playMusic;
-(void)pauseMusic;
@end
