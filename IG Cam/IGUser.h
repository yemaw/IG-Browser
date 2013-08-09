//
//  IGUser.h
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGUser : NSObject
{

}
@property (nonatomic) NSString *user_id;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *full_name;
@property (nonatomic) NSString *profile_picture_url;

@end
