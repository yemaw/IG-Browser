//
//  ImageListViewController.h
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppGlobal.h"
#import "IGPhoto.h"
#import "MusicViewController.h"
#import "SBJson.h"
#import "SBJsonParser.h"

#import "PhotoDetailViewController.h"
#import "FavoriteListViewController.h"
#import "PhotoDataController.h"

@interface PhotoListViewController : UIViewController
{

}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ui_button_favorites;
@property (weak, nonatomic) IBOutlet UISearchBar *ui_searchbar;
@property (weak, nonatomic) IBOutlet UICollectionView *ui_collectionview;

@property (strong, nonatomic) PhotoDataController *data_controller;
@property (strong, nonatomic) NSMutableArray *data_list;



@end
