//
//  MLeaderBoardViewController.h
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;

@interface MLeaderBoardViewController : UITableViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    Reachability* internetReachable;
    Reachability* hostReachable;
}

@property bool internetActive;
@property bool hostActive;
@property (nonatomic, strong) NSMutableArray *winnersArray;

-(void) checkNetworkStatus:(NSNotification *)notice;
@end
