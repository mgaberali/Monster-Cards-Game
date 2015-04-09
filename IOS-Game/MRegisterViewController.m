//
//  MRegisterViewController.m
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MRegisterViewController.h"

@interface MRegisterViewController ()

@end

@implementation MRegisterViewController

// synthesize elements
@synthesize txtf_password, txtf_name, txtf_email, btn_signup, imgv_profileImage;


// signin button pressed method implementation
- (IBAction)signupButtonPressed:(id)sender{
    
    printf("signupButtonPressed\n");
    
    NSString *userName =[txtf_name text];
    NSString *password= [txtf_password text];
    NSString *userEmail= [txtf_email text];
    NSString *userImage= @"aaa";
    
    // POST
    
    
    printf("%s",[userName UTF8String]);
    
    NSString *parameter = [NSString stringWithFormat:@"name=%@&password=%@&email=%@&userImage=%@",userName,password,userEmail,userImage];
    
    
    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d" , [parameterData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //you must change IP to your IP if you will connect on DB
    
    [request setURL:[NSURL URLWithString:@"http://10.145.10.245:8080/IOS-Game-Server/SignupServlet"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:parameterData];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection start];
    
    if( connection )
    {
        printf("connect\n");
        
    }else{
        
        //serverResponse.text = NO_CONNECTION;
        printf("not connect\n");
        
        
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    printf("didReceiveData\n\n\n");
    NSString *msgFromServer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    printf("%s" , [msgFromServer UTF8String]);
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
