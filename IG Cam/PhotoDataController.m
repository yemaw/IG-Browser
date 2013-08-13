//
//  ImageDataController.m
//  IG Cam
//
//  Created by YeMaw on 7/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "PhotoDataController.h"

@implementation PhotoDataController


-(NSMutableArray *)loadDataForTagName:(NSString *)tag{
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@", tag, [AppGlobal getToken]];
    
    return [self loadDataFromURLString:urlString];
}


-(BOOL)testAccessToken{
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed?access_token=%@", [AppGlobal getToken]];
    NSMutableString *responseString = [self loadJSONStringFromURLString:urlString];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonObjects = [jsonParser objectWithString:responseString];
    
    NSString *code = [[jsonObjects objectForKey:@"meta"] objectForKey:@"code"];
    if([code integerValue] > 300 || [code integerValue] < 200){
        //WelcomeViewController *c = [[WelcomeViewController alloc]init];
        //[[[UIApplication sharedApplication] delegate] window].rootViewController = c;
        return NO;
    }
    return YES;
}
-(void)loadDataForLocationId:(NSString *)location{
    
}

-(NSMutableArray *)loadDataFromNextURL{
    
    NSString *urlString = [NSString stringWithFormat:@"%@", self.next_page_url];
    
    return [self loadDataFromURLString:urlString];
}

-(NSMutableString *)loadJSONStringFromURLString:(NSString *)urlString{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:
                                                          [NSString stringWithFormat:@"%@",urlString]]];
    //NSLog(@"request ==> %@", [request description]);
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return [[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding] mutableCopy];
}

-(NSMutableArray *)loadDataFromURLString:(NSString *)urlString{
    NSMutableArray *photo_list = [[NSMutableArray alloc]init];
    
    
    NSString *responseString = [self loadJSONStringFromURLString:urlString];

    //NSLog(@" responseData==> %@",responseString);
    
    NSError *error = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:kNilOptions
                                                                        error:&error];
    
    //NSDictionary *jsonObjects = [jsonParser objectWithString:responseString];
    
    NSDictionary *pagination = [jsonObjects objectForKey:@"pagination"];
    self.next_page_url = [pagination objectForKey:@"next_url"];
    //NSLog(@"next url is %@", self.next_page_url);
    
    NSDictionary *data = [jsonObjects objectForKey:@"data"];
    for(NSDictionary *photo in data){
        IGPhoto *igPhoto = [[IGPhoto alloc]init];
        
        igPhoto.photo_id = [photo objectForKey:@"id"];
        igPhoto.type = [photo objectForKey:@"type"];
        igPhoto.tags = [photo objectForKey:@"tags"];
        
        id _location = [photo objectForKey:@"location"];
        if( _location != nil && ([_location class] != [NSNull class])){
            IGLocation *location = [[IGLocation alloc]init];
            
            id _latitude = [[photo objectForKey:@"location"] objectForKey:@"latitude"];
            if( _latitude != nil && ([_latitude class] != [NSNull class])){
                location.latitude = [[photo objectForKey:@"location"] objectForKey:@"latitude"];
            }
            
            id _longitude = [[photo objectForKey:@"location"] objectForKey:@"longitude"];
            if( _longitude != nil && ([_longitude class] != [NSNull class])){
                location.longitude = [[photo objectForKey:@"location"] objectForKey:@"longitude"];
            }
            
            id _name = [[photo objectForKey:@"location"] objectForKey:@"name"];
            if( _name != nil && ([_name class] != [NSNull class])){
                location.name = [[photo objectForKey:@"location"] objectForKey:@"name"];
            }
            
            id _location_id = [[photo objectForKey:@"location"] objectForKey:@"id"];
            if( _location_id != nil && ([_location_id class] != [NSNull class])){
                location.location_id = [[photo objectForKey:@"location"] objectForKey:@"id"];
            }
            
            igPhoto.location = location;
        }
                
        igPhoto.comments_count = [[[photo objectForKey:@"comments"] objectForKey:@"count"] integerValue];
        igPhoto.comments_rawdata = [[photo objectForKey:@"comments"] objectForKey:@"data"];
        
        igPhoto.likes_count = [[[photo objectForKey:@"likes"] objectForKey:@"count"] integerValue];
        igPhoto.likes_rawdata = [[photo objectForKey:@"likes"] objectForKey:@"data"];
        
        igPhoto.created_time_rawdata = [photo objectForKey:@"created_time"];
        
        id _caption = [photo objectForKey:@"caption"];
        if( _caption != nil && ([_caption class] != [NSNull class])){
            id _text = [[photo objectForKey:@"caption"] objectForKey:@"text"];
            if( _text != nil && ([_text class] != [NSNull class])){
                igPhoto.caption_text = [[photo objectForKey:@"caption"] objectForKey:@"text"];
            }
        }
        
        
        igPhoto.link = [photo objectForKey:@"link"];
        
        igPhoto.image_thumbnail_url = [[[photo objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];
        igPhoto.image_standard_resolution_url = [[[photo objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
        igPhoto.image_low_resolution_url = [[[photo objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
        
        igPhoto.user = [[IGUser alloc] init];//**
        igPhoto.user.user_id = [[photo objectForKey:@"user"] objectForKey:@"id"];
        igPhoto.user.username = [[photo objectForKey:@"user"] objectForKey:@"username"];
        igPhoto.user.full_name = [[photo objectForKey:@"user"] objectForKey:@"full_name"];
        igPhoto.user.profile_picture_url = [[photo objectForKey:@"user"] objectForKey:@"profile_picture"];
        
        [photo_list addObject:igPhoto];
        igPhoto = nil;
    }
    return photo_list;
}

@end
