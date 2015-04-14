//
//  MProfileViewController.h
//  IOS-Game
//
//  Created by JETS on 3/30/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHttpConnection.h"

@interface MProfileViewController : UIViewController

// name textfield
@property (nonatomic, strong) IBOutlet UITextField *txtf_name;

// save button
@property (nonatomic, strong) IBOutlet UIButton *btn_save;

// edit name button
@property (nonatomic, strong) IBOutlet UIButton *btn_editName;

// profile image imageview
@property (nonatomic, strong) IBOutlet UIImageView *imgv_profileImage;

- (IBAction)saveButtonPressed:(id)sender;
-(IBAction)cameraPress:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;

@end
