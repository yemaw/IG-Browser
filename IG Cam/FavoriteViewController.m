//
//  FavoriteViewController.m
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

#define kOFFSET_FOR_KEYBOARD 240.0

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.controller = [[FavoritesController alloc]init];
    
    [self decorateUI];
}

-(void)saveFavorite{
    
    self.data.note = [self.ui_textview_note.text mutableCopy];

    if([self.controller selectFavoritePhoto:self.data.photo_id] == nil){
        [self.controller insertPhoto:self.data];
    } else {
        [self.controller updatePhoto:self.data];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)gotoDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    self.ui_imageview_image.image = self.data.image_physical_low_resolution;
    [self.ui_button_link setTitle:self.data.link forState:UIControlStateNormal];
    self.ui_textview_note.text = self.data.note;
    self.ui_textview_note.font = [UIFont flatFontOfSize:16];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)decorateUI{
    //View
    [self.view setBackgroundColor:[UIColor colorFromHexCode:@"e0e0d8"]];
    
    
    //Save Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveFavorite)];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    [self.navigationItem.rightBarButtonItem configureFlatButtonWithColor:[UIColor wetAsphaltColor] highlightedColor:[UIColor peterRiverColor] cornerRadius:3];

    
    //Set table cell styles
    /*
     for(UILabel *l in self.ui_collection_flatfont){
     l.font = [UIFont boldFlatFontOfSize:16];
     }
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionOpenLink:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.data.link]]];
}


//keyboard move up

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.ui_textview_note])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)actionBackToListView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
