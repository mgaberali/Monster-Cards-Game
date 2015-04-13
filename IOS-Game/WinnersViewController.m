//
//  WinnersViewController.m
//  IOS-Game
//
//  Created by JETS on 4/10/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "WinnersViewController.h"
#import "HWinner.h"
@interface WinnersViewController ()

@end

@implementation WinnersViewController 

//plist
NSString *fullPath;
NSString *filePath;

NSString* response;

NSMutableArray* names;


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
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_app.png"]]];
    //initiating plist file path
    filePath = @"/Users/participant/Desktop/IOS-GAME-GIT/IOS-Game";
    fullPath= [filePath stringByAppendingPathComponent:@"WinnersPList.plist"];
    
    //[self addWinnersToPlist];
    [self getWinnersFromPlist];

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
    cell.imageView.layer.cornerRadius = 50.0;
    
    //curent user email
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *me = [defaults valueForKey:@"email"];

    //cell background image
    if ([[[_winnersArray objectAtIndex:indexPath.row] email] isEqualToString:me]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_app.png"]];
    } else {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_app.png"]];
    }
    
    
    //text label font style
    cell.textLabel.font = [UIFont fontWithName: @"Arial Rounded MT Bold" size: 20.0];
    cell.textLabel.shadowColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
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
       
        // get user image
        NSString *imageString = [[_winnersArray objectAtIndex:indexPath.row] winnerImage];
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageString options:0];
        UIImage *image = [UIImage imageWithData:imageData];
        
        
        //NSString *imageName = [[_winnersArray objectAtIndex:indexPath.row] winnerImage];
        NSMutableString *scoreString= [[NSMutableString alloc] initWithString:@"Score "];
        [scoreString appendString:[[[_winnersArray objectAtIndex:indexPath.row] score] stringValue]];
        UIImage *scaledImage = [self scaleImage:image];
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
    if(originalImage == nil){
        originalImage = [UIImage imageNamed:@"user.png"];
    }
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
    //curent user email
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *me = [defaults valueForKey:@"email"];

    if ([[[_winnersArray objectAtIndex:indexPath.row] email] isEqualToString:me]) {
        cell.textLabel.text = @"Me";
        cell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_app.png"]];
    }
}


@end
