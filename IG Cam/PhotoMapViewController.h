//
//  PhotoMapViewController.h
//  IG Cam
//
//  Created by YeMaw on 12/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

#import "IGPhoto.h"

@interface PhotoMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *ui_mapview;

@property (strong, nonatomic) IGPhoto *data;

@end
