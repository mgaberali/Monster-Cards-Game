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

@interface MHomeViewController ()

@end

@implementation MHomeViewController
//plist
NSString *fullPath;
NSString *filePath;

NSString* response;

NSMutableArray* names;

//connection
Reachability *internetReachableFoo;
bool hostActive;

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

-(void) viewWillAppear:(BOOL)animated
{
    //self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_app.png"]];
    //self.tableView.backgroundColor = [UIColor clearColor];
    
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [hostReachable startNotifier];
    
    // now patiently wait for the notification
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //navigation bar style
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_app.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int score = [[defaults valueForKey:@"score"] intValue];
    _scoreLabel.text = [NSString stringWithFormat:@"Score : %d",score];
	// Do any additional setup after loading the view.
    
    
    //initiating plist file path
    filePath = @"/Users/participant/Desktop/IOS-GAME-GIT/IOS-Game";
    fullPath= [filePath stringByAppendingPathComponent:@"WinnersPList.plist"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leaderBoardButton:(id)sender {
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    printf("%s\n", [response UTF8String]);
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* dictionaries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    names = [NSMutableArray new];
    
    for (NSDictionary* dictionary in dictionaries) {
        NSString* name = [dictionary objectForKey:@"name"];
        [names addObject:name];
    }
    
    printf("----------------------------\n");
    printf("Names:\n");
    for (NSString* name in names) {
        printf("Name: %s\n", [name UTF8String]);
    }
    
    //[self.tableView reloadData];
    [self addWinnersToPlist];

}

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
        //[self addWinnersToPlist];
        printf("Getting top users\n");
        NSURL *url=[[NSURL alloc]initWithString:@"http://10.145.10.245:8080/IOS-Game-Server/TopTen"];
        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
        NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [connection start];
    }
}

@end
