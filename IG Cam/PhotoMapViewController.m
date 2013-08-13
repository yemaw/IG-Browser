//
//  PhotoMapViewController.m
//  IG Cam
//
//  Created by YeMaw on 12/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "PhotoMapViewController.h"

@interface PhotoMapViewController ()

@end

@implementation PhotoMapViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    CLLocationCoordinate2D coordinate;

    coordinate.longitude = [self.data.location.longitude doubleValue];
    coordinate.latitude  = [self.data.location.latitude doubleValue];
    [self annotateMap:coordinate];
}

-(void)annotateMap:(CLLocationCoordinate2D) newCoordinate{
    
    MapAnnotation *ma = [[MapAnnotation alloc] initWithCoordinate:newCoordinate title:[self.data.location.name description]];
    
    [self.ui_mapview addAnnotation:ma];
    [self.ui_mapview setCenterCoordinate:newCoordinate animated:YES];////no more need i think
    
    MKCoordinateRegion region;
    region.center = newCoordinate;
    
    region.span.latitudeDelta = .0001;
    region.span.longitudeDelta = .0001;
    
    
    [self.ui_mapview setRegion:region];
    [self.ui_mapview selectAnnotation:[[MapAnnotation alloc]initWithCoordinate:newCoordinate title:@"It is Here."] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
