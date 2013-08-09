//
//  AppFactory.h
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>

@interface AppGlobal : NSObject

+(NSString *)getToken;

+(void)asyncLoadImageFromURLString:(NSString *)urlString toImageView:(UIImageView *)imageView;

+ (UIImage*) getSubImageFrom: (UIImage*) img WithRect: (CGRect) rect;

+ (BOOL)handleOpenURL:(NSURL *)url ;
@end
