#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

@property (nonatomic, retain) NSCache *imgCache;


#pragma mark - Methods

+ (ImageCache*)sharedImageCache;
- (void) AddURL:(NSString *)imageURL forImage:(UIImage *)image;
- (UIImage*) GetImage:(NSString *)imageURL;
- (BOOL) DoesExist:(NSString *)imageURL;

@end