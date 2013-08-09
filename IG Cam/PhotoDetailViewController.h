//
//  ImageDetailViewController.h
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppGlobal.h"
#import "IGPhoto.h"
#import "FavoritesController.h"
#import "FavoriteViewController.h"
#import <MessageUI/MessageUI.h>

@interface PhotoDetailViewController : UIViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
{

}
@property (weak, nonatomic) IBOutlet UILabel *ui_comments_text;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ui_flat_text_collection;
@property (weak, nonatomic) IBOutlet UIImageView *ui_likes_icon;
@property (weak, nonatomic) IBOutlet UILabel *ui_likes_text;


@property (weak, nonatomic) IBOutlet UILabel *ui_label_username;
@property (weak, nonatomic) IBOutlet UIImageView *ui_image_user;
@property (weak, nonatomic) IBOutlet UIImageView *ui_image_image;

@property (strong, nonatomic) IGPhoto *data;
@end
