//
//  FavoritesViewController.m
//  IG Cam
//
//  Created by YeMaw on 8/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "FavoriteListViewController.h"

@interface FavoriteListViewController ()

@end

@implementation FavoriteListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.controller = [[FavoritesController alloc]init];
    self.data_list  = [[NSMutableArray alloc]init];
    
    
    [self decorateUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.data_list = [self.controller selectAllPhoto];
    [self.ui_tableview_listview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"FavoriteItemCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FavoritePhoto *photo = [self.data_list objectAtIndex:indexPath.row];
    
    UIImageView *thumbnail = (UIImageView *)[cell viewWithTag:106];
    thumbnail.image = photo.image_physical_thumbnail;
    
    UILabel *note = (UILabel *)[cell viewWithTag:107];
    note.font = [UIFont flatFontOfSize:16];
    note.text = photo.note;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FavoriteViewController *favoriteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteViewBoardID"];
    
    FavoritePhoto *photo = [self.data_list objectAtIndex:indexPath.row];

    /*
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
    */
    
    favoriteViewController.data = photo;
    
    //[self.navigationController presentViewController:favoriteViewController animated:YES completion:nil];
    
    [self.navigationController pushViewController:favoriteViewController animated:YES];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         [self.controller deletePhoto:[self.data_list objectAtIndex:indexPath.row]];
         self.data_list = [self.controller selectAllPhoto];
         [self.ui_tableview_listview reloadData];
     }    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)decorateUI{
    //View
    [self.view setBackgroundColor:[UIColor colorFromHexCode:@"e0e0d8"]];
    
    //Navagion Bar
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor wetAsphaltColor]
                                  highlightedColor:[UIColor peterRiverColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18], UITextAttributeTextColor: [UIColor whiteColor]};
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor belizeHoleColor]];
    
    // Dismiss Bar Button Item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(gotoDismiss)];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    [self.navigationItem.rightBarButtonItem configureFlatButtonWithColor:[UIColor wetAsphaltColor] highlightedColor:[UIColor peterRiverColor] cornerRadius:3];
    
    //Set table cell styles
    /*
    for(UILabel *l in self.ui_collection_flatfont){
        l.font = [UIFont boldFlatFontOfSize:16];
    }
    */
    
}

- (void)gotoDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
