//
//  FavoritesViewController.h
//  IG Cam
//
//  Created by YeMaw on 8/8/13.
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

#import "IGPhoto.h"
#import "FavoritePhoto.h"
#import "FavoritesController.h"
#import "FavoriteViewController.h"

@interface FavoriteListViewController : UIViewController
{

}

@property (weak, nonatomic) IBOutlet UITableView *ui_tableview_listview;

@property (strong, nonatomic) NSMutableArray *data_list;
@property (strong, nonatomic) FavoritesController *controller;

@end
