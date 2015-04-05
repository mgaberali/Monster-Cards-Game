//
//  GameScreenViewController.h
//  IOS-Game
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameScreenViewController : UIViewController
@property IBOutlet UIImageView * card;
@property IBOutlet UIButton * btn;
-(IBAction)pressImg:(id)sender;
-(void) addAnimationToButton:(UIButton*) button;

@end
