//
//  MHomeViewController.m
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MHomeViewController.h"
#import "HWinner.h"
#import "HReachability.h"
#import "MHttpConnection.h"

@interface MHomeViewController ()

@end

@implementation MHomeViewController
//plist
NSString *fullPath;
NSString *filePath;

NSString* response;

NSMutableArray* winners;

//connection
Reachability *internetReachableFoo;
bool hostActive;

// synthesize elements
@synthesize btn_facebookShare, btn_leaderBoard, btn_play, btn_profile, btn_login, btn_signout;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    response = [[NSMutableString alloc] initWithString:@""];
    //self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_app.png"]];
    //self.tableView.backgroundColor = [UIColor clearColor];
    
    /*
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [hostReachable startNotifier];
    
    // now patiently wait for the notification
     */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //navigation bar style
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_app.png"] forBarMetrics:UIBarMetricsDefault];
    
    // get data from user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *score = [defaults objectForKey:@"score"];
    NSString *status = [defaults objectForKey:@"status"];
    
    if (score == nil) {
        _scoreLabel.text = [NSString stringWithFormat:@"Score : 0"];
    } else{
        _scoreLabel.text = [NSString stringWithFormat:@"Score : %@",score];
    }
    
    
	
    if( status == nil || [status isEqualToString:@"NO"]){
        
        [btn_profile setEnabled:NO];
        [btn_leaderBoard setEnabled:NO];
        [btn_facebookShare setHidden:YES];
        [btn_login setHidden:NO];
        [btn_signout setHidden:YES];
        //[_scoreLabel setHidden:YES];
        
    }else if([status isEqualToString:@"YES"]){
        
        [btn_profile setEnabled:YES];
        [btn_leaderBoard setEnabled:YES];
        [btn_facebookShare setHidden:NO];
        [btn_login setHidden:YES];
        [btn_signout setHidden:NO];
        
    }
    
    
    //initiating plist file path
    filePath = @"/Users/participant/Desktop/IOSGameGIT/IOS-Game";
    fullPath= [filePath stringByAppendingPathComponent:@"WinnersPList.plist"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leaderBoardButton:(id)sender {
    
}
/*
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
     printf("response %s\n", [response UTF8String]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    printf("response %s\n", [response UTF8String]);
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    //printf(@"%@", [data]);
    NSArray* dictionaries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    winners = [NSMutableArray new];
    
    for (NSDictionary* dictionary in dictionaries) {
        NSString* name = [dictionary objectForKey:@"name"];
        NSString* email = [dictionary objectForKey:@"email"];
        int score = [[dictionary objectForKey:@"score"] intValue];
        NSString *imageName = [dictionary objectForKey:@"imageName"];
        HWinner *winner = [[HWinner alloc] initWithName:name email:email score:[NSNumber numberWithInt:score] winnerImage:imageName];
        //archive the winners objects to be added to the list
        NSData *winnerData = [NSKeyedArchiver archivedDataWithRootObject:winner];
        [winners addObject:winnerData];
        [winners writeToFile:fullPath atomically:YES];
    }
    
    printf("----------------------------\n");
    printf("Names:\n");
    //[self.tableView reloadData];
    //[self addWinnersToPlist];

}
/*
-(void) addWinnersToPlist{
   
    //add the winners to the plist
    HWinner *winner = [[HWinner alloc] initWithName:@"hala" email:@"hala@gmail" score:[NSNumber numberWithInt:5000] winnerImage:@"big.jpg"];
    HWinner *winner2 = [[HWinner alloc] initWithName:@"ahmed" email:@"hala@gmail" score:[NSNumber numberWithInt:3000] winnerImage:@"hala.jpg"];
    HWinner *winner3 = [[HWinner alloc] initWithName:@"hala" email:@"hal@gmail" score:[NSNumber numberWithInt:5000] winnerImage:@"ahmed.jpg"];
    HWinner *winner4 = [[HWinner alloc] initWithName:@"ahmed" email:@"hala@gmail" score:[NSNumber numberWithInt:3000] winnerImage:@"img.jpg"];
    HWinner *winner5 = [[HWinner alloc] initWithName:@"hala" email:@"hala@gmail" score:[NSNumber numberWithInt:5000] winnerImage:@"img.jpg"];
    
    //archive the winners objects to be added to the list
    NSData *winnerData = [NSKeyedArchiver archivedDataWithRootObject:winner];
    NSData *winnerData2 = [NSKeyedArchiver archivedDataWithRootObject:winner2];
    NSData *winnerData3 = [NSKeyedArchiver archivedDataWithRootObject:winner3];
    NSData *winnerData4 = [NSKeyedArchiver archivedDataWithRootObject:winner4];
    NSData *winnerData5 = [NSKeyedArchiver archivedDataWithRootObject:winner5];
    NSData *winnerData6 = [NSKeyedArchiver archivedDataWithRootObject:winner];
    NSData *winnerData7 = [NSKeyedArchiver archivedDataWithRootObject:winner5];
    NSData *winnerData8 = [NSKeyedArchiver archivedDataWithRootObject:winner2];
    NSData *winnerData9 = [NSKeyedArchiver archivedDataWithRootObject:winner2];
    NSData *winnerData10 = [NSKeyedArchiver archivedDataWithRootObject:winner];
    
    //add the archived objects to an array and write the array to the plist file
    NSMutableArray *winners = [NSMutableArray new];
    [winners addObject:winnerData];
    [winners addObject:winnerData2];
    [winners addObject:winnerData3];
    [winners addObject:winnerData4];
    [winners addObject:winnerData5];
    [winners addObject:winnerData6];
    [winners addObject:winnerData7];
    [winners addObject:winnerData8];
    [winners addObject:winnerData9];
    [winners addObject:winnerData10];
    [winners writeToFile:fullPath atomically:YES];
    printf("%s ", "Your data has been saved.");
}
*/
/*
// Checks if we have an internet connection or not
- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet :(");
        });
    };
    
    [internetReachableFoo startNotifier];
}

-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            self.internetActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            self.internetActive = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            self.internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            self.hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self.hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self.hostActive = YES;
            
            break;
        }
    }
    
    if (self.hostActive) {
        /*
        // prepare request parameters
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        // make servlet uri
        NSString *uri = @"IOS-Game-Server/TopTen";
        
        // make http request
        [MHttpConnection makeHttpRequestForUri:uri withMethod:@"GET" withParameters:parameters delegate:self];
        */
        /*
        //[self addWinnersToPlist];
        printf("Getting top users\n");
        NSURL *url=[[NSURL alloc]initWithString:@"http://192.168.1.14:8083/IOS-Game-Server/TopTen"];
        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
        NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        //[connection start];
        
    }
}
*/
- (IBAction)onShareBtnPressed:(id)sender {
    
    // get user data from user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *score = [defaults objectForKey:@"score"];
    NSString *name = [defaults objectForKey:@"name"];

    // link of our application
    NSString *appUrl = @"www.play.google.com";
    
    // App image
    UIImage *image = [UIImage imageNamed:@"toShare.png"];
    
    // make post string
    NSString *postString = [name stringByAppendingString:@" got new score of "];
    postString = [postString stringByAppendingString:score];
    postString = [postString stringByAppendingString:@"\n"];
    
    [MSocialShareUtility sharePostOnFB:postString withLink:appUrl withImage:image fromViewCotroller:self];
    
}
- (IBAction)onSignOutPressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Are you sure you want to logout?" delegate:self  cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        
        // change user status in user defaults
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"NO" forKey:@"status"];
        [userDefaults setObject:[NSString stringWithFormat:@"%d",0] forKey:@"score"];
        
        // hide all buttons except for sign in button
        [btn_profile setEnabled:NO];
        [btn_leaderBoard setEnabled:NO];
        [btn_facebookShare setHidden:YES];
        [btn_login setHidden:NO];
        [btn_signout setHidden:YES];
        _scoreLabel.text = @"Score : 0";

        
    }
}

@end
