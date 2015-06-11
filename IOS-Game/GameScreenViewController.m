//
//  GameScreenViewController.m
//  IOS-Game
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "GameScreenViewController.h"
#import "MHomeViewController.h"
#import "MHttpConnection.h"

@interface GameScreenViewController ()

@end

@implementation GameScreenViewController

int numberOfCards = 16;
NSArray *imagesArray;
BOOL canFlipArray[16];
NSMutableArray *cardsImagesNumbersArray;
bool canFlip;
UIImage *cardDefaultImage;
UIButton *firstCard;
UIButton *secondCard;
int score = 0;
//sound
bool soundOn = YES;

//timer
int timeSec = 0;
int timeMin = 0;
NSTimer *timer;
int timeInSeconds = 0;

NSString *response;

@synthesize imgArray,btnArray,flipped ,pressedBtn1,pressedBtn2;

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
    numberOfCards = 16;
    score = 0;
    soundOn = YES;
    timeSec = 0;
    timeMin = 0;
    timeInSeconds = 0;
    
    //canFlipArray = BOOL canFlipArray[16];
    for (int i =0; i<numberOfCards; i++) {
        canFlipArray[i] = YES;
    }
    
    //timer
    [self StartTimer];
    
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
    UIImage *img6=[UIImage imageNamed:@"shalabi.jpg"];
    UIImage *img7=[UIImage imageNamed:@"ankbot.jpg"];
    UIImage *img8=[UIImage imageNamed:@"monster2.jpg"];
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

//Call This to Start timer, will tick every second
-(void) StartTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer{
    timeInSeconds++;
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    //[timeLabel setStringValue:timeNow];
    _timerLabel.text= timeNow;
}

//Call this to stop the timer event(could use as a 'Pause' or 'Reset')
- (void) stopTimer
{
    [timer invalidate];
    
    timeSec = 0;
    timeMin = 0;
    /*
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    // [timeLabel setStringValue:timeNow];
    _timerLabel.text= timeNow;
    */
}

- (IBAction)soundsetting:(id)sender {
    soundOn = !soundOn;
    //printf("sound on");
    if (soundOn) {
        //UIButton* button = (UIButton *) sender;
        [_soundButton setBackgroundImage:[UIImage imageNamed:@"soundOn.png"] forState:UIControlStateNormal];
    } else {
        [_soundButton setBackgroundImage:[UIImage imageNamed:@"soundOff.png"]forState:UIControlStateNormal];
    }
}

- (IBAction)stopGame:(id)sender {
    [self stopTimer];
    MHomeViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:home animated:YES completion:^(void){
        //home.scoreLabel.text = [NSString stringWithFormat:@"Score : %d",score];
    }];
    
}

-(IBAction)pressImg:(id)sender{
    
    if ( (firstCard == nil || secondCard == nil) && (sender != firstCard && sender != secondCard)) {
        [self playSound:@"sound1"];
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
                        //[self playSound:@"goodLuck"];
                        [firstCard setEnabled:NO];
                        [secondCard setEnabled:NO];
                        
                        score+=200;
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
                            [self stopTimer];
                            [self playSound:@"victory"];
                            [self calcScore];
                            printf("celebrating>>>>>>>>");
                            _celebrateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"celebrate.png"]];
                            
                        } else{
                            [self playSound:@"goodLuck"];
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

-(int) calcScore{
    float timeBonus =  0;
    /*
    NSLog(@"%s",[[NSString stringWithFormat:@"%d",timeInSeconds] UTF8String]);
    for (int i = 1; i<=timeInSeconds; i++) {
       // score += 100/i;
        //_scoreLabel.text = [NSString stringWithFormat:@"%d",score];
        if (timeBonus >= 0) {
            timeBonus*= 100.0f/i;
        }
    }
     */
    timeBonus = 30000/timeInSeconds;
    score += timeBonus;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    //finalScore+= timeBonus;
    
    //write score to user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int lastScore = [[defaults objectForKey:@"score"] integerValue];
    if (lastScore < score) {
        //_celebrateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"highscore.jpg"]];
        [defaults setObject:[NSString stringWithFormat:@"%d",score] forKey:@"score"];
    }
    
    //update the score at the server
    if ([[defaults objectForKey:@"status"] isEqualToString:@"YES"]) {
        [self updateScore];
    }
    
    return score;
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
    if (soundOn) {
        SystemSoundID soundID;
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        
        AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
        AudioServicesPlaySystemSound(soundID);

    }
    
}


// signin button pressed method implementation
- (void) updateScore{
    
    // init response
    response = @"";
    
    // get user data from user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *score = [defaults objectForKey:@"score"];
    NSString *userEmail = [defaults objectForKey:@"email"];
    
 
    // prepare request parameters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:userEmail forKey:@"email"];
    [parameters setObject:score forKey:@"score"];
    
    // make servlet uri
    NSString *uri = @"IOS-Game-Server/UpdateScore";
        
    // make http request
    [MHttpConnection makeHttpRequestForUri:uri withMethod:@"POST" withParameters:parameters delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    if([[responseData objectForKey:@"status"] isEqualToString:@"fail"]){
        
        // show message to user
//        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Updating score" message:@"Server Error" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        
//        [dialog show];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
