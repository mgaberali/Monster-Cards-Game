//
//  MHomeViewController.h
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSocialShareUtility.h"
@class Reachability;

@interface MHomeViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, UIAlertViewDelegate>
{
    Reachability* internetReachable;
    Reachability* hostReachable;
}

- (IBAction)onShareBtnPressed:(id)sender;

// login button
@property (strong, nonatomic) IBOutlet UIButton *btn_login;

// profile button
@property (nonatomic, strong) IBOutlet UIButton *btn_profile;

// leader button
@property (nonatomic, strong) IBOutlet UIButton *btn_leaderBoard;

// play button
@property (nonatomic, strong) IBOutlet UIButton *btn_play;

// facebook share button
@property (nonatomic, strong) IBOutlet UIButton *btn_facebookShare;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)leaderBoardButton:(id)sender;


@property bool internetActive;
@property bool hostActive;
@property (nonatomic, strong) NSMutableArray *winnersArray;

-(void) checkNetworkStatus:(NSNotification *)notice;

- (IBAction)onSignOutPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_signout;

@end
