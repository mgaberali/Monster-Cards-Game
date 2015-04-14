//
//  MSplashScreenViewController.h
//  IOS-Game
//
//  Created by JETS on 3/29/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MSplashScreenViewController : UIViewController

// splash imageview

@property (strong, nonatomic) IBOutlet UIImageView *hole;
@property (strong, nonatomic) IBOutlet UIImageView *ball;
@property (strong, nonatomic) IBOutlet UIImageView *monster;
@property (strong, nonatomic) IBOutlet UIImageView *logo;

@end
