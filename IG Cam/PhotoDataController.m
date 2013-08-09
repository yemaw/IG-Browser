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
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    
    NSDictionary *jsonObjects = [jsonParser objectWithString:responseString];
    
    NSDictionary *data = [jsonObjects objectForKey:@"data"];
    for(NSDictionary *photo in data){
        IGPhoto *igPhoto = [[IGPhoto alloc]init];
        
        igPhoto.photo_id = [photo objectForKey:@"id"];
        igPhoto.type = [photo objectForKey:@"type"];
        igPhoto.tags = [photo objectForKey:@"tags"];
        
        if([photo objectForKey:@"location"] != nil){
            /*
             igPhoto.location = [[IGLocation alloc]init];
             igPhoto.location.longitude = [[photo objectForKey:@"location"] objectForKey:@"longitude"];
             igPhoto.location.latitude  = [[photo objectForKey:@"location"] objectForKey:@"latitude"];
             */
        }
        
        
        igPhoto.comments_count = [[[photo objectForKey:@"comments"] objectForKey:@"count"] integerValue];
        igPhoto.comments_rawdata = [[photo objectForKey:@"comments"] objectForKey:@"data"];
        
        igPhoto.likes_count = [[[photo objectForKey:@"likes"] objectForKey:@"count"] integerValue];
        igPhoto.likes_rawdata = [[photo objectForKey:@"likes"] objectForKey:@"data"];
        
        igPhoto.created_time_rawdata = [photo objectForKey:@"created_time"];
        
        igPhoto.caption_text = [[photo objectForKey:@"caption"] objectForKey:@"text"];
        
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
