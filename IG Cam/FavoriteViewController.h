//
//  FavoriteViewController.h
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGPhoto.h"
#import "FavoritePhoto.h"
#import "FavoritesController.h"

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

@interface FavoriteViewController : UIViewController
{

}
- (IBAction)actionOpenLink:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ui_button_link;
@property (weak, nonatomic) IBOutlet UIImageView *ui_imageview_image;
//@property (weak, nonatomic) IBOutlet UINavigationBar *ui_navbar;
@property (weak, nonatomic) IBOutlet UITextView *ui_textview_note;

@property (strong, nonatomic) NSMutableArray *data_comments;


- (IBAction)actionBackToListView:(id)sender;
@property (strong, nonatomic) FavoritesController *controller;
@property (strong, nonatomic) FavoritePhoto *data;



@end
