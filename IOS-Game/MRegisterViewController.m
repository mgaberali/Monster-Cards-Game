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

@implementation MRegisterViewController{
    
    UIImage *profileImg;
    NSString *response;
    
}

// synthesize elements
@synthesize txtf_password, txtf_name, txtf_email, btn_signup, imgv_profileImage, progressIndicator;


// signin button pressed method implementation
- (IBAction)signupButtonPressed:(id)sender{
    
    // init response
    response = @"";
   
    // get data from textfields
    NSString *userName =[txtf_name text];
    NSString *password= [txtf_password text];
    NSString *userEmail= [txtf_email text];
    
     if([self validateInputs]){
    
         // Encode the Image with Base64
         NSData *imageData = UIImagePNGRepresentation(profileImg);
         NSString *userImage = [imageData base64EncodedStringWithOptions:0];
    
         // prepare request parameters
         NSMutableDictionary *parameters = [NSMutableDictionary new];
         [parameters setObject:userName forKey:@"name"];
         [parameters setObject:userEmail forKey:@"email"];
         [parameters setObject:password forKey:@"password"];
         [parameters setObject:[NSNumber numberWithInt:0] forKey:@"score"];
         [parameters setObject:userImage forKey:@"image"];
    
         // make servlet uri
         NSString *uri = @"IOS-Game-Server/SignupServlet";
    
         // make http request
         [MHttpConnection makeHttpRequestForUri:uri withMethod:@"POST" withParameters:parameters delegate:self];
         
         // show progress
         [self disableAndShowProgress];

     
     }
}

- (void) disableAndShowProgress{
    
    // disable all functionalities
    [btn_signup setEnabled:NO];
    [txtf_name setEnabled:NO];
    [txtf_email setEnabled:NO];
    [txtf_password setEnabled:NO];
    
    // show progress indicator
    [progressIndicator setHidden:NO];
    [progressIndicator startAnimating];
    
}

- (void) enableAndHideProgress{
    
    // enable all functionalities
    [btn_signup setEnabled:YES];
    [txtf_name setEnabled:YES];
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
    if ([[txtf_email text] length] > 0 && [[txtf_name text] length] > 0 && [[txtf_password text] length] > 0) {
        
        //check that name is not only numbers
        NSCharacterSet * numbers=[NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet * inputChar=[NSCharacterSet characterSetWithCharactersInString:[txtf_name text]];
        bool result= [numbers  isSupersetOfSet:inputChar];
        //result is YES if the name is all numbers
        if(result || [[txtf_name text] length] < 3) {
            isValid = NO;
            // show message to user
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:@"Your name must contain at least 3 letters." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [dialog show];
        } else{
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
                UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:@"Invalid email format." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                
                [dialog show];
            } else {
                // validate password is not less than 8 chars
                if ([[txtf_password text] length] < 8) {
                    isValid = NO;
                    // show message to user
                    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:@"Password length is too short." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    
                    [dialog show];
                }

            }
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
    
    
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    if([[responseData objectForKey:@"status"] isEqualToString:@"fail"]){
        
        // hide progress indicator
        [self enableAndHideProgress];
        
        // show message to user
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:@"Email already exists" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
        
    }else{
        
        // show message to user
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:@"Registeration Complete" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [dialog show];
        
        
        // go to home screen
        UIPageViewController *homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        
        [self presentViewController:homeView animated:YES completion:nil];
        
    }
    
    
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
    
    profileImg = [UIImage imageNamed:@"user.png"];
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

    [progressIndicator setHidden:YES];
    
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

- (IBAction)onImagePressed:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:imagePickerController animated:YES];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    
    [picker dismissModalViewControllerAnimated:YES];
    [imgv_profileImage setImage:image];
    profileImg = image;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Server can't be reached" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [dialog show];
    
    // hide progress indicator
    [self enableAndHideProgress];
}

@end
