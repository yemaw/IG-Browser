//
//  AppDelegate.h
//  IG Cam
//
//  Created by YeMaw on 6/8/13.
//  Copyright (c) 2013 Ye Maw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) AVAudioPlayer *audioPlayer;

-(void)playMusic;
-(void)pauseMusic;
-(BOOL)isMusicPlaying;

@end
