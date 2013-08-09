//
//  FavoritesController.h
//  IG Cam
//
//  Created by YeMaw on 8/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

#import "FavoritePhoto.h"

@interface FavoritesController : NSObject
{
    NSString *databasePath;
    sqlite3 *favoriteDB;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
-(NSMutableArray *)selectAllPhoto;
-(FavoritePhoto *)selectFavoritePhoto:(NSString *)photo_id;
-(BOOL)updatePhoto:(FavoritePhoto *)photo;
-(BOOL)insertPhoto:(FavoritePhoto *)photo;
-(BOOL)deletePhoto:(FavoritePhoto *)photo;

@end
