//
//  LocalPhoto.h
//  IG Cam
//
//  Created by YeMaw on 9/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritePhoto : NSObject
{

}

@property (nonatomic) NSInteger *favorite_id;
@property (nonatomic) NSMutableString *photo_id;
@property (nonatomic) NSMutableString *note;
@property (nonatomic) NSMutableString *link;


@property (nonatomic) UIImage *image_physical_thumbnail;
@property (nonatomic) UIImage *image_physical_low_resolution;
@property (nonatomic) UIImage *image_physical_standard_resolution;

@end
