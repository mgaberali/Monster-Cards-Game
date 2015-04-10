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

/*
-(void) back:(UIBarButtonItem *) backButton{
    [self.navigationController popViewControllerAnimated:YES];

}
//scale the image to fit the table view cell
-(UIImage *) scaleImage:(UIImage *) originalImage{
    
    CGRect rect = CGRectMake(0,0,79,29);
    UIGraphicsBeginImageContext( rect.size );
    [originalImage drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    
    return img;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //back button style
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    // Add Home Button
    //self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor clearColor];
//    UIImage *backImage = [self scaleImage:[UIImage imageNamed:@"back.png"]];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backImage style:2 target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = backButton;

    //another try
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(0, 0, 79, 29.0);
//    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [self.navigationItem.leftBarButtonItem setTarget:self];
    
    
    UIView *paddingViewLeft3 = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 47, 20)];
    txtf_name.leftView = paddingViewLeft3;
    txtf_name.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingViewRight3 = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 10, 20)];
    txtf_name.rightView = paddingViewRight3;
    txtf_name.rightViewMode = UITextFieldViewModeAlways;
    
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
