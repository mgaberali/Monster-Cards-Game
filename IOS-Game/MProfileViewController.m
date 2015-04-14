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

@implementation MProfileViewController{
    UIImage *profileImg;
    NSString *userEmail;
    NSString *password;
    NSString *userName;
    NSString *response;
}

@synthesize progressIndicator;

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
    
    [progressIndicator setHidden:YES];
    
    // init response
    response = @"";
    
    // get user name from user defaults
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *name=[userDefaults objectForKey:@"name"];
    
    // get user image from user defaults
    NSString *imageString=[userDefaults objectForKey:@"image"];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageString options:0];
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (image == nil) {
        image = [UIImage imageNamed:@"user.png"];
    }
    
    // set name and image
    [_txtf_name setText:name];
    [_imgv_profileImage setImage:image];
    
	// Do any additional setup after loading the view.
    userEmail = [userDefaults objectForKey:@"email"];
    password = [userDefaults objectForKey:@"password"];
    profileImg = image;
    
    //textfield padding
    UIView *paddingViewLeft3 = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 47, 20)];
    _txtf_name.leftView = paddingViewLeft3;
    _txtf_name.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingViewRight3 = [[UIView alloc] initWithFrame:CGRectMake(160, 206, 10, 20)];
    _txtf_name.rightView = paddingViewRight3;
    _txtf_name.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) disableAndShowProgress{
    
    // disable all functionalities
    [_txtf_name setEnabled:NO];
    [_btn_save setEnabled:NO];
    
    // show progress indicator
    [progressIndicator setHidden:NO];
    [progressIndicator startAnimating];
    
}

- (void) enableAndHideProgress{
    
    // enable all functionalities
    [_txtf_name setEnabled:YES];
    [_btn_save setEnabled:YES];
    
    // hide progress indicator
    [progressIndicator setHidden:YES];
    [progressIndicator stopAnimating];
}


- (IBAction)saveButtonPressed:(id)sender{
    
    // get data from textfields
    userName =_txtf_name.text;
    
    if([self validateInputs]){
        
        // Encode the Image with Base64
        profileImg = [self scaleImage:profileImg];
        NSData *imageData = UIImagePNGRepresentation(profileImg);
        NSString *userImage = [imageData base64EncodedStringWithOptions:0];
        
        // get user score from user defaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *score = [defaults objectForKey:@"score"];
        
        // prepare request parameters
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setObject:userName forKey:@"name"];
        [parameters setObject:userEmail forKey:@"email"];
        [parameters setObject:password forKey:@"password"];
        [parameters setObject:userImage forKey:@"image"];
        [parameters setObject:score forKey:@"score"];
        
        // make servlet uri
        NSString *uri = @"IOS-Game-Server/EditProfileServlet";
        
        // make http request
        [MHttpConnection makeHttpRequestForUri:uri withMethod:@"POST" withParameters:parameters delegate:self];
        
        // show progress
        [self disableAndShowProgress];

    }

}

//scale the image to decrease its size
-(UIImage *) scaleImage:(UIImage *) originalImage{
    if(originalImage == nil){
        originalImage = [UIImage imageNamed:@"user.png"];
    }
    CGRect rect = CGRectMake(0,0,100,100);
    UIGraphicsBeginImageContext( rect.size );
    [originalImage drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    
    return img;
}


/*
 * This method is for validation
 */
- (Boolean) validateInputs{
    
    Boolean isValid = YES;
    
    // validate if textfields are not empty
    if ([[_txtf_name text] length] > 0) {
        
        //check that name is not only numbers
        NSCharacterSet * numbers=[NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet * inputChar=[NSCharacterSet characterSetWithCharactersInString:[_txtf_name text]];
        bool result= [numbers  isSupersetOfSet:inputChar];
        //result is YES if the name is all numbers
        if(result || [[_txtf_name text] length] < 3) {
            isValid = NO;
            // show message to user
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Edit profile" message:@"Your name must contain at least 3 letters." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [dialog show];
        }
    } else {
        isValid = NO;
        // show message to user
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:@"Please, Fill the required fields." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
    }
    return isValid;
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    NSString *msgFromServer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:msgFromServer];
    
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    if([[responseData objectForKey:@"status"] isEqualToString:@"fail"]){
        
        // hide progress indicator
        [self enableAndHideProgress];
        
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Edit Profile" message:@"Something went wrong! Try again" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
        
    }else if([[responseData objectForKey:@"status"] isEqualToString:@"success"]){
        
        // Encode the Image with Base64
        NSData *imageData = UIImagePNGRepresentation(profileImg);
        NSString *userImage = [imageData base64EncodedStringWithOptions:0];
        
        // save user data in user defaults
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userName forKey:@"name"];
        [userDefaults setObject:userImage forKey:@"image"];
        
        // show message to user
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Edit Profile" message:@"Data Saved Successfully" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
        
        // go to home screen
        UIPageViewController *homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
        
        [self presentViewController:homeView animated:YES completion:nil];
        
    }
    
    
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
    
    // set image profile
    profileImg = image;
    
    [_imgv_profileImage setImage:image];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Server can't be reached" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [dialog show];
    
    // hide progress indicator
    [self enableAndHideProgress];
}

@end
