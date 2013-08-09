//
//  FavoritesController.m
//  IG Cam
//
//  Created by YeMaw on 8/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "FavoritesController.h"

@implementation FavoritesController

-(id)init{
    self = [super init];
    if(self){
        //[self openDatabaseConnection];
    }
    return self;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"fail to save image");
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

-(void)openDatabaseConnection{
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[documentsDir stringByAppendingPathComponent:@"favorites.sqlite"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if([filemgr fileExistsAtPath:databasePath] == NO){
        const char *dbpath = [databasePath UTF8String];
        if(sqlite3_open(dbpath, &favoriteDB) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS favorite (favorite_id INTEGER PRIMARY KEY AUTOINCREMENT, photo_id TEXT, note TEXT, link TEXT)";
            
            if(sqlite3_exec(favoriteDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                sqlite3_close(favoriteDB);
            } else {
                //
            }
            
        }
    } else {
        const char *dbpath = [databasePath UTF8String];
        if(sqlite3_open(dbpath, &favoriteDB) != SQLITE_OK){
            NSLog(@"Fail to open DB!");
            //self.statusLabel.text = @"Fail to open DB!";
        }
    }   
}


-(NSMutableArray *)selectAllPhoto
{
    [self openDatabaseConnection];
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    
    NSString *q= [NSString stringWithFormat:@"SELECT favorite_id, photo_id, note, link FROM favorite"];
    
    const char *query_stmt = [q UTF8String];
    
    sqlite3_prepare_v2(favoriteDB, query_stmt, -1, &statement, NULL);
    
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    while(sqlite3_step(statement) == SQLITE_ROW){
        FavoritePhoto *photo = [[FavoritePhoto alloc]init];
        
        //photo.favorite_id = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 0)] integerValue];
        photo.photo_id = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)] mutableCopy];
        photo.note = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 2)] mutableCopy];
        photo.link = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 3)] mutableCopy];
        
        
        photo.image_physical_thumbnail = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@%@%@", documentsDir, @"/thumbnail_", photo.photo_id, @".png"]];
        
        photo.image_physical_low_resolution = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@%@%@", documentsDir, @"/low_resolution_", photo.photo_id, @".png"]];
        
        [results addObject:photo];
    }
    sqlite3_close(favoriteDB);
    return results;
}

-(FavoritePhoto *)selectFavoritePhoto:(NSString *)photo_id{
    [self openDatabaseConnection];
    sqlite3_stmt *statement;
    
    NSString *q= [NSString stringWithFormat:@"SELECT favorite_id, photo_id, note, link FROM favorite WHERE photo_id = \"%@\" LIMIT 1", photo_id];
    const char *query_stmt = [q UTF8String];
    
    sqlite3_prepare_v2(favoriteDB, query_stmt, -1, &statement, NULL);
    
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    FavoritePhoto *photo = [[FavoritePhoto alloc]init];
    BOOL *found = FALSE;
    while(sqlite3_step(statement) == SQLITE_ROW){
        found = TRUE;
        
        //photo.favorite_id = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 0)] integerValue];
        photo.photo_id = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)] mutableCopy];
        photo.note = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 2)] mutableCopy];
        photo.link = [[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 3)] mutableCopy];

        photo.image_physical_thumbnail = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@%@%@", documentsDir, @"/thumbnail_", photo.photo_id, @".png"]];
        
        photo.image_physical_low_resolution = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@%@%@", documentsDir, @"/low_resolution_", photo.photo_id, @".png"]];
    }
    sqlite3_close(favoriteDB);
    if(found){
        return photo;
    }
    return nil;
}


-(BOOL)updatePhoto:(FavoritePhoto *)photo{

    NSString *q = [NSString stringWithFormat:@"UPDATE favorite SET note = \"%@\" WHERE photo_id = \"%@\"", photo.note, photo.photo_id];

    if([self execSql:q] == SQLITE_DONE){
        return YES;
    }else {
        return NO;
    }
}

-(BOOL)insertPhoto:(FavoritePhoto *)photo{

    NSString *q = [NSString stringWithFormat:@"INSERT INTO favorite (photo_id, note, link) values (\"%@\",\"%@\",\"%@\")", photo.photo_id, photo.note, photo.link];
    
    if([self execSql:q] == SQLITE_DONE){
        //Saving file to physical storage
        NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        [self saveImage:photo.image_physical_low_resolution withFileName:[NSString stringWithFormat:@"low_resolution_%@", photo.photo_id] ofType:@"png" inDirectory:documentsDir];
        
        [self saveImage:photo.image_physical_thumbnail withFileName:[NSString stringWithFormat:@"thumbnail_%@", photo.photo_id] ofType:@"png" inDirectory:documentsDir];
        
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)deletePhoto:(FavoritePhoto *)photo{
    NSString *q = [NSString stringWithFormat:@"DELETE FROM favorite WHERE photo_id = \"%@\" ", photo.photo_id];
    
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    if([self execSql:q] == SQLITE_DONE){
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@%@%@%@", documentsDir, @"/thumbnail_", photo.photo_id, @".png"] error:NULL];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@%@%@%@", documentsDir, @"/low_resolution_", photo.photo_id, @".png"] error:NULL];
        return YES;
    } else {
        return NO;
    }
}

-(int)execSql:(NSString *)stmt{
   [self openDatabaseConnection];

    sqlite3_stmt *statement;
    const char *sql_stmt = [stmt UTF8String];
    
    sqlite3_prepare_v2(favoriteDB, sql_stmt, -1, &statement, NULL);
    int i =sqlite3_step(statement);
    
    sqlite3_close(favoriteDB);

    return i;
}

@end
