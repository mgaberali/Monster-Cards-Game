//
//  GameScreenViewController.m
//  IOS-Game
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "GameScreenViewController.h"

@interface GameScreenViewController ()

@end

@implementation GameScreenViewController
@synthesize card ,btn;
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
    UIImage * img=[UIImage imageNamed:@"img1.png"];
    //NSArray * images=[NSArray new];
    //images = @[[UIImage imageNamed:@"img1.png"],
    //    [UIImage imageNamed:@"img2.png"],
    //  [UIImage imageNamed:@"img3.png"]];
    /*[card setAnimationImages:images] ;
    card.animationDuration = 0.5;
    card.animationRepeatCount = 1;
    [card startAnimating];
*/
    [btn setBackgroundImage:img  forState:UIControlStateNormal];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressImg:(id)sender{
    printf("kmlmlkmklm");
    UIImage * img=[UIImage imageNamed:@"img2.png"];

   // [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    
    //[self addAnimationToButton:btn];
    //[[btn imageView] startAnimating]; //or stopAnimating
    
    [UIView transitionWithView:btn duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [btn setBackgroundImage:[UIImage imageNamed:@"img2.png"] forState:UIControlStateNormal];
    }   completion:^(BOOL abc){
        
        
        [UIView transitionWithView:btn duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [btn setBackgroundImage:[UIImage imageNamed:@"img1.png"] forState:UIControlStateNormal];
        }   completion:nil];
        
        
        
        
    } ];

   
}

-(void) addAnimationToButton:(UIButton*) button{
    UIImageView* animationView = [button imageView];
    NSArray* animations=[NSArray arrayWithObjects:
                         [UIImage imageNamed:@"img1.png"],
                         [UIImage imageNamed:@"img2.png"],
                         [UIImage imageNamed:@"img3.png"],
                         //and so on if you need more
                         nil];
    CGFloat animationDuration = 2.0;
    [animationView setAnimationImages:animations];
    [animationView setAnimationDuration:animationDuration];
    [animationView setAnimationRepeatCount:0]; //0 is infinite
}

@end
