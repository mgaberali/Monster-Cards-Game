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

NSInteger *arr[] = { 1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8};
@synthesize  btn,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10,btn11,btn12,btn13,btn14,btn15,btn16;
@synthesize imgArray,btnArray,flipped ,pressedBtn1,pressedBtn2;
@synthesize img;

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
    img=[UIImage imageNamed:@"question.png"];
    UIImage * img1=[UIImage imageNamed:@"mared.png"];
    UIImage * img2=[UIImage imageNamed:@"sali.jpg"];
    UIImage * img3=[UIImage imageNamed:@"roz.jpg"];
    UIImage * img4=[UIImage imageNamed:@"boo.jpg"];
    UIImage * img5=[UIImage imageNamed:@"andl.jpg"];
    UIImage * img6=[UIImage imageNamed:@"img.jpg"];
    UIImage * img7=[UIImage imageNamed:@"default.png"];
    UIImage * img8=[UIImage imageNamed:@"hala.jpg"];
    
    imgArray=[[NSArray alloc]initWithObjects:img1,img2,img3,img4,img5,img6,img7,img8,nil];
    // btnArray=@[1,@2,@3,@4,@5,@6,@7,@8,@1,@2,@3,@4,@5,@6,@7,@8];
    btnArray =[NSMutableArray new];
    
    
    flipped=NO;
    pressedBtn2=pressedBtn1=NULL;
    
    
    //NSArray * images=[NSArray new];
    //images = @[[UIImage imageNamed:@"img1.png"],
    //    [UIImage imageNamed:@"img2.png"],
    //  [UIImage imageNamed:@"img3.png"]];
    /*[card setAnimationImages:images] ;
     card.animationDuration = 0.5;
     card.animationRepeatCount = 1;
     [card startAnimating];
     */
    int x=arr[0];
    //x--;
    printf("%d",x);
    [btn setBackgroundImage:img   forState:UIControlStateNormal];
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
    UIImage * img=[UIImage imageNamed:@"default.png"];
    //NSArray * images=[NSArray new];
    //images = @[[UIImage imageNamed:@"img1.png"],
    //    [UIImage imageNamed:@"img2.png"],
    //  [UIImage imageNamed:@"img3.png"]];
    /*[card setAnimationImages:images] ;
    card.animationDuration = 0.5;
    card.animationRepeatCount = 1;
    [card startAnimating];
*/
    /*
    for (UIButton *card in _cardsCollection) {
        [card setBackgroundImage:img  forState:UIControlStateNormal];
    }
     */
    
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
    if(flipped==NO){
        pressedBtn1=(UIButton *)sender;
        flipped=YES;
        int  x=arr[pressedBtn1.tag-1];
        [UIView transitionWithView:pressedBtn1 duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [pressedBtn1 setBackgroundImage:imgArray[x-1] forState:UIControlStateNormal];
        }   completion:nil];
    }
    else{
        pressedBtn2=(UIButton *)sender;
        if(pressedBtn1.tag !=pressedBtn2.tag){
            int  x=arr[pressedBtn2.tag-1];
            int  x2=arr[pressedBtn1.tag-1];
            
            [UIView transitionWithView:pressedBtn2 duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                [pressedBtn2 setBackgroundImage:imgArray[x-1] forState:UIControlStateNormal];
            }   completion:^(BOOL abc){
                
                if(x!=x2)
                {
                    [UIView transitionWithView:pressedBtn2 duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                        [pressedBtn2 setBackgroundImage:img forState:UIControlStateNormal];
                    }   completion:nil];
                    
                    
                    [UIView transitionWithView:pressedBtn1 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                        [pressedBtn1 setBackgroundImage:img forState:UIControlStateNormal];
                    }   completion:nil];
                    
                    
                } else{
                    [pressedBtn1 setEnabled:NO];
                    [pressedBtn2 setEnabled:NO];
                }
            } ];
            flipped=NO;
            
            
        }
    }
    
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
