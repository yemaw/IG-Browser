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
#import "PhotoMapViewController.h"
#import <MessageUI/MessageUI.h>
#import <GameKit/GameKit.h>

@interface PhotoDetailViewController : UIViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate,GKSessionDelegate, GKPeerPickerControllerDelegate>
{

}
@property (weak, nonatomic) IBOutlet UIImageView *ui_locationplacemark_image;
@property (weak, nonatomic) IBOutlet UILabel *ui_location_text;
- (IBAction)actionBackToListView:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ui_comments_text;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ui_flat_text_collection;
@property (weak, nonatomic) IBOutlet UIImageView *ui_likes_icon;
@property (weak, nonatomic) IBOutlet UILabel *ui_likes_text;


@property (weak, nonatomic) IBOutlet UILabel *ui_label_username;
@property (weak, nonatomic) IBOutlet UIImageView *ui_image_user;
@property (weak, nonatomic) IBOutlet UIImageView *ui_image_image;

@property (strong, nonatomic) IGPhoto *data;


@property (nonatomic, retain) GKSession *currentSession;
@property (nonatomic, retain) IBOutlet GKPeerPickerController *picker;

-(void) btnSendBT;
-(void) btnConnectBT;
-(void) btnDisconnectBT;
-(void) doneEditing:(id) sender;


@end
