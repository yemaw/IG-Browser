//
//  PhotoUploadViewController.h
//  IG Cam
//
//  Created by YeMaw on 12/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGInstagram.h"

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


@interface PhotoUploadViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *ui_imageview;

@property (strong, nonatomic) UIImage *photo;

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end
