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

@implementation MLoginViewController

// synthesize elements
@synthesize txtf_email, txtf_password, btn_register, btn_sigin;


// signin button pressed method implementation
- (IBAction)signinButtonPressed:(id)sender{
    
    ////////hey///////
    
    printf("signinButtonPressed");
    
    NSString * mail=[txtf_email text];
    
    NSString * password=[txtf_password text];
    
    BOOL mailNotEmpty = mail != nil && ![mail isEqualToString:@""];
    BOOL passwordNotEmpty = password != nil && ![password isEqualToString:@""];
    
    if (mailNotEmpty && passwordNotEmpty) {
        
        NSString *parameter = [NSString stringWithFormat:@"mail=%@&password=%@",mail,password];
        
        
        NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d" , [parameterData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:@"http://10.145.10.245:8080/IOS-Game-Server/LoginServlet"]];
        
        [request setHTTPMethod:@"POST"];
        
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [request setHTTPBody:parameterData];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        [connection start];
        
        if( connection )
        {
            printf("connect\n");
            
            //open home view
            //identify in storyboard ->home
            //
            
//            UIPageViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
//            [self presentViewController:newView animated:YES completion:nil];
//            [self.navigationController pushViewController:newView animated:nil];
            
        }else{
            
            printf("not connect");
            
            //open login view again
            
        }
        
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    printf("didReceiveData\n");
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    printf("%s" , [result UTF8String]);
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

    //navigation bar style
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_app.png"] forBarMetrics:UIBarMetricsDefault];
    
	// Do any additional setup after loading the view.
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

@end
