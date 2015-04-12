//
//  MProfileViewController.m
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MProfileViewController.h"

@interface MProfileViewController ()

@end

@implementation MProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * name=[userDefaults objectForKey:@"name"];
    [_txtf_name setText:name];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(id)sender{
    
    printf("signupButtonPressed\n");
    
    NSString *userName =_txtf_name.text;
    
    ////from useeeeeeeeeeeer defaults
    NSString *password= @"77777";
    NSString *userEmail= @"fromios";
    NSString *userImage= @"aaa";
    
    // POST
    
    
    printf("%s",[userName UTF8String]);
    
    NSString *parameter = [NSString stringWithFormat:@"name=%@&password=%@&email=%@&userImage=%@",userName,password,userEmail,userImage];
    
    
    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d" , [parameterData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //you must change IP to your IP if you will connect on DB
    
    [request setURL:[NSURL URLWithString:@"http://192.168.74.1:8084/IOS-Game-Server/EditProfileServlet"]];
    
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

-(IBAction)cameraPress:(id)sender{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];

}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    [_imgv_profileImage setImage:image];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
