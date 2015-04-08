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

int numberOfCards = 16;
NSArray *imagesArray;
BOOL canFlipArray[] = {YES,YES,YES,YES,YES,YES,YES,YES,YES,YES,YES,YES,YES,YES,YES,YES};
NSMutableArray *cardsImagesNumbersArray;
bool canFlip;
UIImage *cardDefaultImage;
UIButton *firstCard;
UIButton *secondCard;
int score = 0;

//NSInteger *arr[] = { 1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8};
//@synthesize  btn,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10,btn11,btn12,btn13,btn14,btn15,btn16;
@synthesize imgArray,btnArray,flipped ,pressedBtn1,pressedBtn2;
//@synthesize img;

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
    //celebration subview
    [self.view addSubview:_celebrateView];
    [super viewDidLoad];
    
    
    //default image
    cardDefaultImage = [UIImage imageNamed:@"question.png"];
    
    //images to display on cards
    UIImage *img1=[UIImage imageNamed:@"mared.png"];
    UIImage *img2=[UIImage imageNamed:@"sali.jpg"];
    UIImage *img3=[UIImage imageNamed:@"roz.jpg"];
    UIImage *img4=[UIImage imageNamed:@"boo.jpg"];
    UIImage *img5=[UIImage imageNamed:@"andl.jpg"];
    UIImage *img6=[UIImage imageNamed:@"img.jpg"];
    UIImage *img7=[UIImage imageNamed:@"default.png"];
    UIImage *img8=[UIImage imageNamed:@"hala.jpg"];
    imagesArray = [[NSArray alloc]initWithObjects:img1,img2,img3,img4,img5,img6,img7,img8,nil];
    
    //randomize images positions
    cardsImagesNumbersArray = [NSMutableArray array];
    int i = 0;
    while(i < numberOfCards) {
        int randomNumber = arc4random() % numberOfCards/2;
        
        int occurrences = 0;
        for(NSNumber *cardNumber in cardsImagesNumbersArray){
            occurrences += ([cardNumber isEqualToNumber:[NSNumber numberWithInt:randomNumber]]?1:0);
        }
        if (occurrences < 2) {
            //NSLog(@"random number = %i", randomNumber);
            [cardsImagesNumbersArray addObject:[NSNumber numberWithInt:randomNumber]];
            i++;
        }
        
    }
    
    //initialize the tow cards to be matched
    firstCard = secondCard = nil;
    flipped=NO;
    
   
    for (UIButton *card in _cardsCollection) {
        card.layer.cornerRadius = 30;
        card.clipsToBounds = YES;
        [card setBackgroundImage:cardDefaultImage  forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressImg:(id)sender{
    
    if ( (firstCard == nil || secondCard == nil) && (sender != firstCard && sender != secondCard)) {
        [self playSound:@"flip"];
        if(flipped==NO){
            flipped = YES;
            firstCard=(UIButton *)sender;
            //NSLog(@"first number  = %i", [cardsImagesNumbersArray[firstCard.tag-1] intValue]);
            NSNumber *firstImageIndex = [cardsImagesNumbersArray objectAtIndex:[firstCard tag]-1];
            UIImage *firstImage=[imagesArray objectAtIndex: [firstImageIndex intValue]];
            
            [UIView transitionWithView:firstCard duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                [firstCard setBackgroundImage:firstImage forState:UIControlStateNormal];
            }   completion:nil];
            

        } else{
            secondCard = (UIButton*) sender;
            //NSLog(@"second number  = %i", [cardsImagesNumbersArray[secondCard.tag-1] intValue]);
            if(firstCard.tag != secondCard.tag){
                NSNumber *secondImageIndex = [cardsImagesNumbersArray objectAtIndex:[secondCard tag]-1];
                UIImage *secondImage=[imagesArray objectAtIndex: [secondImageIndex intValue]];
                
                [UIView transitionWithView:secondCard duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                    [secondCard setBackgroundImage:secondImage forState:UIControlStateNormal];
                }   completion:^(BOOL abc){
                    
                    //NSLog(@"second number  = %i", [cardsImagesNumbersArray[secondCard.tag-1] intValue]);
                    
                    if(cardsImagesNumbersArray[firstCard.tag-1] != cardsImagesNumbersArray[secondCard.tag-1])
                    {
                        [UIView transitionWithView:secondCard duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                            [secondCard setBackgroundImage:cardDefaultImage forState:UIControlStateNormal];
                        }   completion:nil];
                        
                        [UIView transitionWithView:firstCard duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                            [firstCard setBackgroundImage:cardDefaultImage forState:UIControlStateNormal];
                        }   completion:nil];
                        [self playSound:@"hardLuck"];
                        firstCard = secondCard = nil;
                        
                    } else{
                        [self playSound:@"victory"];
                        [firstCard setEnabled:NO];
                        [secondCard setEnabled:NO];
                        
                        score+=20;
                        _scoreLabel.text = [NSString stringWithFormat:@"%d",score];
                        
                        //update array of cards that are flipped
                        int firstIndex = [firstCard tag]-1;
                        int secondIndex = [secondCard tag]-1;
                        canFlipArray[firstIndex] = NO;
                        canFlipArray[secondIndex] = NO;
                        
                        bool celebrate = YES;
                        for (int i = 0; i<numberOfCards; i++) {
                            //printf("in canFlip");
                            printf("%d",canFlipArray[i]);
                            if (canFlipArray[i] == YES) {
                                celebrate = NO;
                                break;
                            }
                        }
                        if (celebrate) {
                            printf("celebrating>>>>>>>>");
                            _celebrateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"celebrate.png"]];
                            //self.tableView.backgroundColor = [UIColor clearColor];
                        } else{
                            printf("no celebration");
                        }
                        
                        firstCard = secondCard = nil;
                    }
                } ];
                flipped=NO;
            }
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


-(void) playSound:(NSString *) soundName{
    /*
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
    */
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
