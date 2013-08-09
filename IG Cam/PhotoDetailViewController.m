//
//  ImageDetailViewController.m
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()
@property (nonatomic) UIImageView *imagecontainer_standard_resolution; //Use to preload thumbnail image for share function
@property (nonatomic) UIImageView *imagecontainer_low_resolution;
@property (nonatomic) UIImageView *imagecontainer_thumbnail;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self cutomizeUI];
    
    [AppGlobal asyncLoadImageFromURLString:self.data.image_standard_resolution_url toImageView:self.ui_image_image];
    [AppGlobal asyncLoadImageFromURLString:self.data.user.profile_picture_url toImageView:self.ui_image_user];
    self.ui_label_username.text = self.data.user.username;
    
    //Share Button
    UIImage* share_img = [UIImage imageNamed:@"share_btn.png"];
    CGRect frame_img = CGRectMake(0, 0, 40, 20);
    UIButton *share_btn = [[UIButton alloc] initWithFrame:frame_img];
    [share_btn setBackgroundImage:share_img forState:UIControlStateNormal];
    [share_btn addTarget:self action:@selector(showActionSheet:)
           forControlEvents:UIControlEventTouchUpInside];
    [share_btn setShowsTouchWhenHighlighted:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share_btn];
    
    //just a trick to preloaded the image for share function
    self.imagecontainer_standard_resolution = [[UIImageView alloc]init];
    [AppGlobal asyncLoadImageFromURLString:self.data.image_standard_resolution_url toImageView:self.imagecontainer_standard_resolution];
    
    self.imagecontainer_low_resolution = [[UIImageView alloc]init];
    [AppGlobal asyncLoadImageFromURLString:self.data.image_low_resolution_url toImageView:self.imagecontainer_low_resolution];
    self.imagecontainer_thumbnail = [[UIImageView alloc]init];
    [AppGlobal asyncLoadImageFromURLString:self.data.image_thumbnail_url toImageView:self.imagecontainer_thumbnail];
}
-(void)viewWillAppear:(BOOL)animated{
    self.ui_likes_text.text = [NSString stringWithFormat:@"%i likes" ,self.data.likes_count];
    self.ui_comments_text.text = [NSString stringWithFormat:@"%i comments" ,self.data.comments_count];
}



- (void) cutomizeUI{
    self.ui_label_username.font = [UIFont boldSystemFontOfSize:15.0f];
}

- (void)showActionSheet:(id)sender //Define method to show action sheet
{
    
    NSString *actionSheetTitle = @"Share"; //Action Sheet Title
    NSString *favorite = @"Add to Favorite";
    NSString *facebook = @"Share on Facebook";
    NSString *twitter  = @"Share on Twitter";
    NSString *email    = @"Share with Email";
    NSString *cancelTitle = @"Cancel";
    

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
															 delegate:self
													cancelButtonTitle:cancelTitle
											   destructiveButtonTitle:nil
													otherButtonTitles:favorite, facebook, twitter, email, nil];
    [actionSheet setBackgroundColor: [UIColor wetAsphaltColor]];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex){
        case 0:
            [self addToFavorite:nil];
            break;
        case 1:
            [self shareToFacebook:nil];
            break;
        case 2:
            [self shareToTwitter:nil];
            break;
        case 3:
            [self shareToEmail:nil];
            break;
    }
    
}

- (void)addToFavorite:(id)sender{
    FavoriteViewController *favoriteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteViewBoardID"];
    
    FavoritePhoto *photo = [[FavoritePhoto alloc]init];
    photo.photo_id  = self.data.photo_id;
    photo.note  = [NSString stringWithFormat:@"Photo by %@. %@.", self.data.user.username, self.data.caption_text];
    photo.link =  self.data.link;
    
    if(self.imagecontainer_thumbnail.image != nil){
        photo.image_physical_thumbnail = self.imagecontainer_thumbnail.image;
    } else {
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.data.image_thumbnail_url]];
        photo.image_physical_thumbnail = [[UIImage alloc] initWithData:data];
    }
    
    if(self.imagecontainer_low_resolution.image != nil){
        photo.image_physical_low_resolution = self.imagecontainer_low_resolution.image;
    } else {
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.data.image_low_resolution_url]];
        photo.image_physical_low_resolution = [[UIImage alloc] initWithData:data];
    }
    
    favoriteViewController.data = photo;
    
    //[self.navigationController presentViewController:favoriteViewController animated:YES completion:nil];

    [self.navigationController pushViewController:favoriteViewController animated:YES];
    
    /*
    FavoritesController *favoriteController = [[FavoritesController alloc]init];
    if([favoriteController insertPhoto:self.data]){
        NSLog(@"Saved");
    } else {
        NSLog(@"Failed");
    }*/
}

- (IBAction)shareToTwitter:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                //NSLog(@"Cancelled");
            } else
            {
                //NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler = myBlock;
        
        [controller setInitialText:[NSString stringWithFormat:@"Photo by %@. %@.", self.data.user.full_name, self.data.caption_text]];
        [controller addURL:[NSURL URLWithString:self.data.link]];
        
        if(self.imagecontainer_standard_resolution.image != nil){
            [controller addImage:self.imagecontainer_standard_resolution.image];
        } else {
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.data.image_standard_resolution_url]];
            [controller addImage:[[UIImage alloc] initWithData:data]];
        }

        
        [self presentViewController:controller animated:YES completion:Nil];
    }

}

- (IBAction)shareToFacebook:(id)sender {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                //NSLog(@"Cancelled");
            } else {
               //NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler = myBlock;
        
        [controller setInitialText:[NSString stringWithFormat:@"Photo by %@. %@.", self.data.user.full_name, self.data.caption_text]];
        [controller addURL:[NSURL URLWithString:self.data.link]];
        
        if(self.imagecontainer_standard_resolution.image != nil){
            [controller addImage:self.imagecontainer_standard_resolution.image];
        } else {
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.data.image_standard_resolution_url]];
            [controller addImage:[[UIImage alloc] initWithData:data]];
        }
        
        
        
        [self presentViewController:controller animated:YES completion:Nil];
    }
    
}

- (IBAction)shareToEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Check out this photo."];
        
        UIImage *myImage = self.ui_image_image.image;
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"an_image_from_instagram"];
        
        NSString *emailBody = [NSString stringWithFormat:@"Check out this photo on instagram. Original link is <a href=\"%@\">here</a>", self.data.link];
        [mailer setMessageBody:emailBody isHTML:YES];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentViewController:mailer animated:YES completion:nil];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
