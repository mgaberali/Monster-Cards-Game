//
//  MRegisterViewController.h
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHttpConnection.h"

@interface MRegisterViewController : UIViewController

// name textfield
@property (nonatomic, strong) IBOutlet UITextField *txtf_name;

// email textfield
@property (nonatomic, strong) IBOutlet UITextField *txtf_email;

// password textfield
@property (nonatomic, strong) IBOutlet UITextField *txtf_password;

// signup button
@property (nonatomic, strong) IBOutlet UIButton *btn_signup;

// profile image imageview
@property (nonatomic, strong) IBOutlet UIImageView *imgv_profileImage;

// on image profile pressed
- (IBAction)onImagePressed:(id)sender;

// signup button pressed method
- (IBAction)signupButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;

@end
