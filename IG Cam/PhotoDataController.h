//
//  ImageDataController.h
//  IG Cam
//
//  Created by YeMaw on 7/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppGlobal.h"
#import "SBJsonParser.h"
#import "IGPhoto.h"
#import "AppDelegate.h"
#import "WelcomeViewController.h"

@interface PhotoDataController :NSObject
{

}
-(NSMutableArray *)loadDataForTagName:(NSString *)tag;
-(void)loadDataForLocationId:(NSString *)location;
-(NSMutableArray *)loadDataFromURLString:(NSString *)urlString;
-(BOOL)testAccessToken;
@end
