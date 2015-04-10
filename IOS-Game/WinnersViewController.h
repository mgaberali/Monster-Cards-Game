//
//  WinnersViewController.h
//  IOS-Game
//
//  Created by JETS on 4/10/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WinnersViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *winnersArray;

@end
