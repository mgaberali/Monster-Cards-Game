//
//  MLoginViewController.m
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MLoginViewController.h"

@interface MLoginViewController ()

@end

@implementation MLoginViewController{
    
    NSString *mail;
    NSString *password;
    
}

// synthesize elements
@synthesize txtf_email, txtf_password, btn_register, btn_sigin ,response, progressIndicator;


// signin button pressed method implementation
- (IBAction)signinButtonPressed:(id)sender{
    
    // init response
    response = @"";
    
    // get email and password from text fields
    mail =[txtf_email text];
    password=[txtf_password text];
    
   
    if([self validateInputs]){
    
        // prepare request parameters
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setObject:mail forKey:@"email"];
        [parameters setObject:password forKey:@"password"];
    
        // make servlet uri
        NSString *uri = @"IOS-Game-Server/LoginServlet";

        // make http request
        [MHttpConnection makeHttpRequestForUri:uri withMethod:@"POST" withParameters:parameters delegate:self];
    
        
        // show progress
        [self disableAndShowProgress];
        
        
    }
 
}

- (void) disableAndShowProgress{
    
    // disable all functionalities
    [btn_register setEnabled:NO];
    [btn_sigin setEnabled:NO];
    [txtf_email setEnabled:NO];
    [txtf_password setEnabled:NO];
    
    // show progress indicator
    [progressIndicator setHidden:NO];
    [progressIndicator startAnimating];
    
}

- (void) enableAndHideProgress{
    
    // enable all functionalities
    [btn_register setEnabled:YES];
    [btn_sigin setEnabled:YES];
    [txtf_email setEnabled:YES];
    [txtf_password setEnabled:YES];
    
    // hide progress indicator
    [progressIndicator setHidden:YES];
    [progressIndicator stopAnimating];
}

/*
 * This method is for validation
 */
- (Boolean) validateInputs{
    
    Boolean isValid = YES;
    
    // validate if textfields are not empty
    if ([[txtf_email text] length] > 0 && [[txtf_password text] length] > 0) {
        
    // validate email using regx
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //isValid = [emailTest evaluateWithObject:[txtf_email text]];
    if ([emailTest evaluateWithObject:[txtf_email text]] == NO) {
        isValid = NO;
        // show message to user
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign In" message:@"Invalid email format." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
        [dialog show];
    } else {
        // validate password is not less than 8 chars
        if ([[txtf_password text] length] < 8) {
            isValid = NO;
            // show message to user
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign In" message:@"Password length is too short." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                
            [dialog show];
        }
    }

    } else {
        isValid = NO;
        // show message to user
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign In" message:@"Please, Fill the required fields." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
    }
    return isValid;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    if([[responseData objectForKey:@"status"] isEqualToString:@"fail"]){
        
        // enable and hide progress indicator
        [self enableAndHideProgress];
        
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Signing in" message:@"Invalid Email/Password" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
        
    }else{
        
        // save user data in user defaults
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[responseData objectForKey:@"name"] forKey:@"name"];
        [userDefaults setObject:mail forKey:@"email"];
        [userDefaults setObject:password forKey:@"password"];
        [userDefaults setObject:[responseData objectForKey:@"score"] forKey:@"score"];
        [userDefaults setObject:[responseData objectForKey:@"image"] forKey:@"image"];
        [userDefaults setObject:@"YES" forKey:@"status"];
        
        // go to home screen
        UIPageViewController *homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
        
        [self presentViewController:homeView animated:YES completion:nil];

    }
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
  
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];

}
 

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


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
 
    [progressIndicator setHidden:YES];
    
    UIView *paddingViewLeft = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 47, 20)];
    txtf_email.leftView = paddingViewLeft;
    txtf_email.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingViewRight = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 10, 20)];
    txtf_email.rightView = paddingViewRight;
    txtf_email.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewLeft2 = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 47, 20)];
    txtf_password.leftView = paddingViewLeft2;
    txtf_password.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingViewRight2 = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 10, 20)];
    txtf_password.rightView = paddingViewRight2;
    txtf_password.rightViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Server can't be reached" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [dialog show];
    
    // hide progress indicator
    [self enableAndHideProgress];
}

@end
