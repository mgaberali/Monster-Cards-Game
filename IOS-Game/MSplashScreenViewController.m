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

@implementation MSplashScreenViewController{
    
    UIDynamicAnimator *animator;
    Boolean firstHit;
}

// synthesize splash imageview
@synthesize logo, monster, hole, ball;

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
    
    firstHit = YES;
    
    // show hole after 1 second
    [self performSelector:@selector(showHole) withObject:nil afterDelay:1];
    
    // play sound
    [self playSound:@"jumb"];
    
    // show ball and animate it after 1 second
    [self performSelector:@selector(showBall) withObject:nil afterDelay:1];
    
    
    
    // go to home screen after 5 seconds
    [self performSelector:@selector(goToHomeScreen) withObject:nil afterDelay:4];
    
    
}

- (void) showLogo{
    [logo setHidden:NO];
}

- (void) hideLogo{
    [logo setHidden:YES];
}

- (void) showBall{
    
    // show ball
    [ball setHidden:NO];
    
    
    
    // int animator
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // add gravity behaviour to ball
    [self addGravityToBall];
    
    // add boundry collision to ball
    [self addBoundryCollision];
    
    // controll ball elaticity
    [self ControllBallElicity];

    // hide hole and animate it after 1 second
    [self performSelector:@selector(hideHole) withObject:nil afterDelay:1];

    
}

- (void) hideBall{
    [ball setHidden:YES];
}

- (void) showMonster{
    [monster setHidden:NO];
}

- (void) hideMonster{
    [monster setHidden:YES];
}

- (void) showHole{
    [hole setHidden:NO];
}

- (void) hideHole{
    [hole setHidden:YES];
}

- (void) addGravityToBall{
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.ball]];
    [animator addBehavior:gravity];
    
}

- (void) addBoundryCollision{
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.ball]];
    
    [collision addBoundaryWithIdentifier:@"tabBar" fromPoint:CGPointMake(monster.frame.origin.x, monster.frame.origin.y+monster.frame.size.height) toPoint:CGPointMake(monster.frame.origin.x+monster.frame.size.width, monster.frame.origin.y+monster.frame.size.height)];
    
    collision.collisionDelegate = self;
    
    [animator addBehavior:collision];
}

- (void) ControllBallElicity{
    
    UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ball]];
    behavior.elasticity = 0.75;
    
    [animator addBehavior:behavior];
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
    
    if(firstHit){
        
        firstHit = NO;
        
        [self hideBall];
        [self showLogo];
        
        // play sound
        [self playSound:@"appear"];
        
        //[self showMonster];
    
        // hide monster and animate it after 1 second
       // [self performSelector:@selector(hideMonster) withObject:nil afterDelay:1];

        // show logo and animate it after 1 second
        //[self performSelector:@selector(showLogo) withObject:nil afterDelay:1];
        
    }
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier{
    
    
}

-(void) playSound:(NSString *) soundName{
 
    
        SystemSoundID soundID;
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        
        AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    
    
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
