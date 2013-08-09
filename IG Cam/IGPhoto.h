//
//  IGPhoto.h
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGUser.h"
#import "IGComment.h"
#import "IGLocation.h"

@interface IGPhoto : NSObject
{

}
@property (nonatomic) NSMutableString *photo_id;

@property (nonatomic) NSMutableString *type;

@property (nonatomic) NSMutableArray *tags;

@property (nonatomic) IGLocation *location;

@property int comments_count;
@property (nonatomic) NSMutableArray *comments_rawdata;

@property int likes_count;
@property (nonatomic) NSMutableArray *likes_rawdata;

@property (nonatomic) NSMutableString *caption_text;

@property (nonatomic) NSMutableString *link;

@property (nonatomic) NSMutableString *created_time_rawdata;

@property (nonatomic) NSMutableString *image_thumbnail_url;
@property (nonatomic) NSMutableString *image_low_resolution_url;
@property (nonatomic) NSMutableString *image_standard_resolution_url;

@property (nonatomic) IGUser *user;
@property (nonatomic) NSMutableString *from_username;
@property (nonatomic) NSMutableString *from_profilepicture;


@end
