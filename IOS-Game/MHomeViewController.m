//
//  MHomeViewController.m
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MHomeViewController.h"

@interface MHomeViewController ()

@end

@implementation MHomeViewController

// synthesize elements
@synthesize btn_facebookShare, btn_leaderBoard, btn_play, btn_profile;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //navigation bar style
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_app.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int score = [[defaults valueForKey:@"score"] intValue];
    _scoreLabel.text = [NSString stringWithFormat:@"Score : %d",score];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
