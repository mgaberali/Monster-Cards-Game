//
//  GameScreenViewController.h
//  IOS-Game
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface GameScreenViewController : UIViewController

/*
@property IBOutlet UIButton * btn;
@property IBOutlet UIButton * btn2;
@property IBOutlet UIButton * btn3;
@property IBOutlet UIButton * btn4;
@property IBOutlet UIButton * btn5;
@property IBOutlet UIButton * btn6;
@property IBOutlet UIButton * btn7;
@property IBOutlet UIButton * btn8;
@property IBOutlet UIButton * btn9;
@property IBOutlet UIButton * btn10;
@property IBOutlet UIButton * btn11;
@property IBOutlet UIButton * btn12;
@property IBOutlet UIButton * btn13;
@property IBOutlet UIButton * btn14;
@property IBOutlet UIButton * btn15;
@property IBOutlet UIButton * btn16;
*/

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsCollection;


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property NSArray *imgArray;
@property NSMutableArray *btnArray;
@property BOOL flipped;
@property UIButton *pressedBtn1, *pressedBtn2;

@property UIImage * img;

@property (strong, nonatomic) IBOutlet UIView *celebrateView;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsArray;
- (IBAction)stopGame:(id)sender;

- (IBAction)soundsetting:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;


- (IBAction)stopGame:(id)sender;










-(IBAction)pressImg:(id)sender;
-(void) addAnimationToButton:(UIButton*) button;

@end
