//
//  PhotoUploadViewController.m
//  IG Cam
//
//  Created by YeMaw on 12/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "PhotoUploadViewController.h"

@interface PhotoUploadViewController ()

@end

@implementation PhotoUploadViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Favorite Button
    UIImage* favorite_img = [UIImage imageNamed:@"sendto.png"];
    CGRect frame_img = CGRectMake(0, 0, 46, 23);
    UIButton *favorite_btn = [[UIButton alloc] initWithFrame:frame_img];
    [favorite_btn setBackgroundImage:favorite_img forState:UIControlStateNormal];
    [favorite_btn addTarget:self action:@selector(gotoUpload)
           forControlEvents:UIControlEventTouchUpInside];
    [favorite_btn setShowsTouchWhenHighlighted:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:favorite_btn];
    
    [self decorateUI];
}

-(void)gotoUpload{
    UIImage *image = self.ui_imageview.image;
    
    if ([MGInstagram isAppInstalled])
    {
        //[MGInstagram postImage:image inView:self.view];
        [MGInstagram postImage:image withCaption:@"" inView:self.view];

    }
    else
    {
        NSLog(@"Error Instagram is either not installed or image is incorrect size");
    }
}


-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    double width=newSize.width;
    double height=newSize.height;
    
    if(image.size.width<newSize.width)
        width=image.size.width;
    if(image.size.height<newSize.height)
        height=image.size.height;
    
    newSize=CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)decorateUI{
    [self.view setBackgroundColor:[UIColor colorFromHexCode:@"e0e0d8"]];
    
}


-(void) viewWillAppear:(BOOL)animated{

    self.ui_imageview.image =  self.photo;//[self cropImage:self.photo toRect:CGRectMake(0,0,612,612)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect {

    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return img;
}


@end
