//
//  ImageListViewController.m
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "PhotoListViewController.h"
#import "SBJsonParser.h"

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

@class SBJsonParser;

@interface PhotoListViewController ()

@end

@implementation PhotoListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data_controller = [[PhotoDataController alloc] init];
    self.data_list = [[NSMutableArray alloc] init];
    self.image_cache = [ImageCache sharedImageCache];

    if([self.data_controller testAccessToken] == NO){
        WelcomeViewController *c = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewControllerRootBoardID"];
        [[[UIApplication sharedApplication] delegate] window].rootViewController = c;
        return;
    }

    //Music Button Item
    UIImage* music_img = [UIImage imageNamed:@"camera.png"];
    CGRect frame_img1 = CGRectMake(0, 0, 36, 15);
    UIButton *music_btn = [[UIButton alloc] initWithFrame:frame_img1];
    [music_btn setBackgroundImage:music_img forState:UIControlStateNormal];
    [music_btn addTarget:self action:@selector(gotoMusicView)
           forControlEvents:UIControlEventTouchUpInside];
    [music_btn setShowsTouchWhenHighlighted:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:music_btn];
    //music end
    
    [self decorateUI];

    
    //Favorite Button
    UIImage* favorite_img = [UIImage imageNamed:@"favorite_btn.png"];
    CGRect frame_img = CGRectMake(0, 0, 40, 20);
    UIButton *favorite_btn = [[UIButton alloc] initWithFrame:frame_img];
    [favorite_btn setBackgroundImage:favorite_img forState:UIControlStateNormal];
    [favorite_btn addTarget:self action:@selector(gotoFavoriteView)
        forControlEvents:UIControlEventTouchUpInside];
    [favorite_btn setShowsTouchWhenHighlighted:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:favorite_btn];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.ui_searchbar resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"end");
    [self.ui_searchbar resignFirstResponder];
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{ 
    [self.ui_searchbar resignFirstResponder];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.ui_searchbar resignFirstResponder];
    self.title = [NSString stringWithFormat:@"#%@", searchBar.text];
    
    self.data_list = nil;
    [self.ui_collectionview reloadData];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        self.data_list = [self.data_controller loadDataForTagName:searchBar.text];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.ui_collectionview reloadData];
        });
    });
    
    
}
/*
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchBar.text = [searchBar.text stringByReplacingOccurrencesOfString:@" "
                                                               withString:@""];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if(([indexPath row]+1) == self.data_list.count){

        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSMutableArray *temp = [self.data_controller loadDataFromNextURL];
            for(int i=0; i<temp.count;i++)
            {
                [self.data_list addObject:[temp objectAtIndex:i]];
//                NSLog(@"current count is -> %i", self.data_list.count);
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.ui_collectionview reloadData];
            });
        });
        
    }
    
    static NSString *identifier = @"ImageThumbnailCellSBID";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *thumbnail = (UIImageView *)[cell viewWithTag:105];
    
    IGPhoto *photo = [self.data_list objectAtIndex:indexPath.row];
    NSString *imageUrl = photo.image_thumbnail_url;

    if ([[ImageCache sharedImageCache] DoesExist:imageUrl] == true)
    {
        thumbnail.image = [[ImageCache sharedImageCache] GetImage:imageUrl];
    } else {
        //NSURL *url = [[NSBundle mainBundle] URLForResource:@"loding" withExtension:@"gif"];
        //thumbnail.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        thumbnail.image = [UIImage imageNamed:@"loding.gif"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                     [NSURL URLWithString:imageUrl]]];
            [self.image_cache AddURL:imageUrl forImage:image];
            dispatch_sync(dispatch_get_main_queue(), ^{
                thumbnail.image = image;
                [cell setNeedsLayout];
            });
        });
    }
    
    
    /*
    if (imageUrl) {
        if ([[ImageStore sharedStore] imageForKey:imageUrl]) {
            [[cell imageView] setImage:[[ImageStore sharedStore] imageForKey:imageUrl]];
        } else {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                         [NSURL URLWithString:imageUrl]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    thumbnail.image = image;
                    [cell setNeedsLayout];
                });
            });
    */
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoDetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoDetailViewControllerStoryBoardID"];
    dvc.data = [self.data_list objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:dvc animated:YES];
    
    
}



- (void)decorateUI{
    [self.view setBackgroundColor:[UIColor colorFromHexCode:@"e0e0d8"]];

    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor wetAsphaltColor]
                                highlightedColor:[UIColor peterRiverColor]
                                cornerRadius:3
                                whenContainedIn:[UINavigationBar class], nil];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18], UITextAttributeTextColor: [UIColor whiteColor]};
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor belizeHoleColor]];
    
    //Search Bar
    [[self.ui_searchbar.subviews objectAtIndex:0] removeFromSuperview]; //Container is always at index0
    [self.ui_searchbar setBackgroundColor:[UIColor cloudsColor]];
}

-(void)gotoFavoriteView{
    FavoriteListViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteListViewBoardID"];
    [self.navigationController presentViewController:toViewController animated:YES completion:nil];
}

-(void)gotoMusicView{
    MusicViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicViewNavigationControllerBoardID"];
    [self.navigationController presentViewController:toViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
