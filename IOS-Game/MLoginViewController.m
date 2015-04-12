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
@synthesize txtf_email, txtf_password, btn_register, btn_sigin ,response;


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
    
        
    }
 
}

/*
 * This method is for validation
 */
- (Boolean) validateInputs{
    
    // validate if textfields are not empty
    
    // validate email using regx
    
    
    // must show ui alert view to user
    
    return YES;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    if([[responseData objectForKey:@"status"] isEqualToString:@"fail"]){
        
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
