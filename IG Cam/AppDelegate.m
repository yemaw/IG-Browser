//
//  AppDelegate.m
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import "AppDelegate.h"
#import "AppGlobal.h"
#import "WelcomeViewController.h"
#import "PhotoDataController.h"
#import "PhotoListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSError *error = nil;
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:@"zombies" withExtension:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
    [self.audioPlayer setNumberOfLoops:-1];
    
    //Make sure the system follows our playback status
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    //Load the audio into memory
    [self.audioPlayer prepareToPlay];
    
    PhotoDataController *photoDataController = [[PhotoDataController alloc]init];
    if([photoDataController testAccessToken] == NO){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                                 bundle: nil];
        
        
        WelcomeViewController *loginController = (WelcomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"PhotoListNavigationControllerBoardID"];
        self.window.rootViewController = loginController;
    }
    
    return YES;
}
-(void)playMusic{
    [self.audioPlayer play];
}
-(void)pauseMusic{
    [self.audioPlayer pause];
}
-(BOOL)isMusicPlaying{
    return self.audioPlayer.playing;
}

// YOU NEED TO CAPTURE igAPPID:// schema
/*
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"-->1");
    NSLog(@"==> %@", [url description]);
    return YES;
    //return [self.instagram handleOpenURL:url];
}
*/
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    NSLog(@"==> %@", [url description]);
    if([AppGlobal handleOpenURL:url]){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                                 bundle: nil];
        
        PhotoListViewController *loginController = (PhotoListViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"PhotoListNavigationControllerBoardID"];
        self.window.rootViewController = loginController;
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
