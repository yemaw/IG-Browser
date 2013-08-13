//
//  MapAnnotation.h
//  ISS_Workshop_GeoCoderAndMapKitB
//
//  Created by YeMaw on 5/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotation : NSObject <MKAnnotation>{
    NSString *title;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(id) initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *) t;

@end
