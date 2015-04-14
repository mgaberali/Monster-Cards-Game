//
//  MLeaderBoardViewController.m
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MLeaderBoardViewController.h"
#import "HWinner.h"
#import "HReachability.h"

@interface MLeaderBoardViewController ()

@end

@implementation MLeaderBoardViewController

//plist
NSString *fullPath;
NSString *filePath;

NSString* response;

NSMutableArray* names;

//connection
Reachability *internetReachableFoo;
bool hostActive;


//NSArray *winnersArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    [self setTitle:@"Leader Board"];
    //navigation bar style
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_app.png"] forBarMetrics:UIBarMetricsDefault];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //initiating plist file path
    filePath = @"/Users/participant/Desktop/IOSGameGIT/IOS-Game";
    fullPath= [filePath stringByAppendingPathComponent:@"WinnersPList.plist"];
    
    [self addWinnersToPlist];
    [self getWinnersFromPlist];
    
    
    printf("Getting top users\n");
    NSURL *url=[[NSURL alloc]initWithString:@"http://192.168.74.1:8084/IOS-Game-Server/TopTen"];
    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
    response = @"";
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Server can't be reached" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [dialog show];
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
    
    [self.tableView reloadData];
}

-(void) addWinnersToPlist{
    if (_internetActive) {
        printf("%s", "\n internet is reachable");
    } else {
        printf("%s", "\n internet is not reachable");
    }
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

-(void) getWinnersFromPlist{
    
    //initialize the winners array that will hold the winners unarchived objects
    _winnersArray = [[NSMutableArray alloc] init];
    
    //read the winners from the plist
    NSArray *winnersArrayArchived = [[NSArray alloc] initWithContentsOfFile:fullPath];
    for (int i =0; i< winnersArrayArchived.count; i++) {
        printf("%s  ","\n object found ");
        //unarchive the winner object to be added to the winnersArray
        NSData *winnerData = [winnersArrayArchived objectAtIndex:i];
        HWinner *winnerRead = [NSKeyedUnarchiver unarchiveObjectWithData:winnerData];
        [_winnersArray addObject:winnerRead];
        printf("%s  ", [[winnerRead name] UTF8String]);
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (names != nil) {
        return [names count];
    }
    
    if (_winnersArray != nil) {
        return _winnersArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    //rounded image
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 25.0;
    
    //cell background image
    if ([[[_winnersArray objectAtIndex:indexPath.row] email] isEqualToString:@"hal@gmail"]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"highlightedBG.png"]];
    } else {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_orange.png"]];
    }
    
    
    //text label font style
    cell.textLabel.font = [UIFont fontWithName: @"Arial Rounded MT Bold" size: 20.0];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
//    
//    //detail text label font style
    cell.detailTextLabel.font = [UIFont fontWithName: @"Arial Rounded MT Bold" size: 16.0];
    cell.detailTextLabel.shadowColor = [UIColor whiteColor];
    
    //    [cell.imageView setBounds:CGRectMake(0, 0, 40, 40)];
    //    [cell.imageView setClipsToBounds:NO];
    //    [cell.imageView setFrame:CGRectMake(0, 0, 40, 40)];
    //    [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    //cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 75,75);
    
    
    
    // Configure the cell...
    if (_winnersArray != nil) {
            if ([[[_winnersArray objectAtIndex:indexPath.row] winnerImage] isEqualToString:@"hal.gmail"]) {
            }
            NSString *imageName = [[_winnersArray objectAtIndex:indexPath.row] winnerImage];
            NSMutableString *scoreString= [[NSMutableString alloc] initWithString:@"Score "];
            [scoreString appendString:[[[_winnersArray objectAtIndex:indexPath.row] score] stringValue]];
            UIImage *scaledImage = [self scaleImage:[UIImage imageNamed:imageName]];
            cell.textLabel.text = [[_winnersArray objectAtIndex:indexPath.row] name];
            cell.imageView.image =scaledImage;
            cell.detailTextLabel.text = scoreString;
    
        } else {
            cell.textLabel.text = @"default";
            cell.detailTextLabel.text = @"default";
        }
    
    //cell.textLabel.text = [names objectAtIndex:indexPath.row];
    
    return cell;
}

//scale the image to fit the table view cell
-(UIImage *) scaleImage:(UIImage *) originalImage{
    
    CGRect rect = CGRectMake(0,0,75,75);
    UIGraphicsBeginImageContext( rect.size );
    [originalImage drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    
    return img;
}

//disable the selection of any cell to prevent getting it highlighted
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

//-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView cellForRowAtIndexPath:indexPath].backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default.jpg"]];
//}

//change the style of the cell of the player
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[_winnersArray objectAtIndex:indexPath.row] email] isEqualToString:@"hal@gmail"]) {
        cell.textLabel.text = @"Me";
        cell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"highlightedBG.png"]];
    }
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

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
}
@end
