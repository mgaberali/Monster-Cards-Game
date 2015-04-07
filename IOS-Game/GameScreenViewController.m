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
@synthesize  btn,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10,btn11,btn12,btn13,btn14,btn15,btn16;
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
    [btn2 setBackgroundImage:img  forState:UIControlStateNormal];

    [btn3 setBackgroundImage:img  forState:UIControlStateNormal];

    [btn4 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn5 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn6 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn7 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn8 setBackgroundImage:img  forState:UIControlStateNormal];
    
    [btn9 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn12 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn10 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn11 setBackgroundImage:img  forState:UIControlStateNormal];

    [btn13 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn14 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn15 setBackgroundImage:img  forState:UIControlStateNormal];
    [btn16 setBackgroundImage:img  forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressImg:(id)sender{
    [self playSound];
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

-(void) playSound{
    int randomSoundNumber = arc4random() % 4; //random number from 0 to 3
    
    NSLog(@"random sound number = %i", randomSoundNumber);
    
    NSString *effectTitle;
    
    switch (randomSoundNumber) {
        case 0:
            effectTitle = @"sound1";
            break;
        case 1:
            effectTitle = @"sound2";
            break;
        case 2:
            effectTitle = @"sound3";
            break;
        case 3:
            effectTitle = @"sound4";
            break;
            
        default:
            break;
    }
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
