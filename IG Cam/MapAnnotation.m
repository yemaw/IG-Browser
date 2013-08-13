//
//  MapAnnotation.m
//  ISS_Workshop_GeoCoderAndMapKitB
//
//  Created by YeMaw on 5/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize title,coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t{
    if(self = [super init]){
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"viewForAnnotation");
    
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *annotationIdentifier = @"AnnotationIdentifier";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [mapView
                                                            dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView)
    {
        pinView = [[MKPinAnnotationView alloc]
                    initWithAnnotation:annotation
                    reuseIdentifier:annotationIdentifier];
        
        [pinView setPinColor:MKPinAnnotationColorGreen];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        
        UIImageView *houseIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pinmark.png"]];
        pinView.leftCalloutAccessoryView = houseIconView;
    }
    else 
    {
        pinView.annotation = annotation;
    }
    
    return pinView; 
}
*/
@end
