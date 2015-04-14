//
//  WinnersViewController.h
//  IOS-Game
//
//  Created by JETS on 4/10/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;

@interface WinnersViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    Reachability* internetReachable;
    Reachability* hostReachable;
}
@property (nonatomic, strong) NSMutableArray *winnersArray;
- (IBAction)refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *winnersTable;

@property bool internetActive;
@property bool hostActive;
-(void) checkNetworkStatus:(NSNotification *)notice;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;
@end
