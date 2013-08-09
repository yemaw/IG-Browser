//
//  AppFactory.m
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "AppGlobal.h"

@implementation AppGlobal

+(NSString *)getToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"access_token"];
    //return @"42729168.6c6980e.f0d86419d71b45978f4a52da633c38aa";
}

+(void)asyncLoadImageFromURLString:(NSString *)urlString toImageView:(UIImageView *)imageView{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                 [NSURL URLWithString:urlString]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}

// get sub image
+ (UIImage*) getSubImageFrom: (UIImage*) img WithRect: (CGRect) rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, img.size.width, img.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // draw image
    [img drawInRect:drawRect];
    
    // grab image
    UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return subImage;
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    // If the URL's structure doesn't match the structure used for Instagram authorization, abort.
    //if (![[url absoluteString] hasPrefix:[self getOwnBaseUrl]]) {
    //    return NO;
    //}
    
    NSString *query = [url fragment];
    if (!query) {
        query = [url query];
    }
    
    NSDictionary *params = [self parseURLParams:query];
    NSString *accessToken = [params valueForKey:@"access_token"];
    
    // If the URL doesn't contain the access token, an error has occurred.
    if (!accessToken) {
        //        NSString *error = [params valueForKey:@"error"];
        
        //NSString *errorReason = [params valueForKey:@"error_reason"];
        
        //*BOOL userDidCancel = [errorReason isEqualToString:@"user_denied"];
        //*[self igDidNotLogin:userDidCancel];
        NSLog(@"login not ok");
        return NO;
    }
    
    //    // We have an access token, so parse the expiration date.
    //    NSString *expTime = [params valueForKey:@"expires_in"];
    //    NSDate *expirationDate = [NSDate distantFuture];
    //    if (expTime != nil) {
    //        int expVal = [expTime intValue];
    //        if (expVal != 0) {
    //            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
    //        }
    //    }
    
    //[self igDidLogin:accessToken/* expirationDate:expirationDate*/];
    NSLog(@"login ok");
    NSLog(@"token key -> %@", accessToken);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"access_token"];
    [defaults synchronize];
    NSLog(@"save key -> %@", [defaults objectForKey:@"access_token"]);
    return YES;
}

+ (NSDictionary*)parseURLParams:(NSString *)query {
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	for (NSString *pair in pairs) {
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		NSString *val = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
		[params setObject:val forKey:[kv objectAtIndex:0]];
	}
    return params;
}



@end
