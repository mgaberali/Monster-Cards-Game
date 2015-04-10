//
//  MSplashScreenViewController.m
//  IOS-Game
//
//  Created by JETS on 3/29/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MSplashScreenViewController.h"

@interface MSplashScreenViewController ()

@end

@implementation MSplashScreenViewController

// synthesize splash imageview
@synthesize splashImageView;

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
	// Do any additional setup after loading the view.
    
    // create empty images array
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    // load images into images array
    for(int i =0; i<28; i++){
        
        NSString *imageName = [NSString stringWithFormat:@"splash-%d.png",i+1];
        [images addObject:[UIImage imageNamed:imageName]];
    }
    
    // start animation with duration of 2 seconds
    splashImageView.animationImages = images;
    splashImageView.animationDuration = 2;
    [splashImageView startAnimating];
    
    
    // go to home screen after 5 seconds
    [self performSelector:@selector(goToHomeScreen) withObject:nil afterDelay:5];
    
    
}

- (void) goToHomeScreen{
    
    MHomeViewController *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:homeScreen animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
