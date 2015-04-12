//
//  MSocialShareUtility.h
//  IOS-Game
//
//  Created by JETS on 4/3/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface MSocialShareUtility : NSObject

+ (void) sharePostOnFB: (NSString *) postString withLink: (NSString *) url withImage: (UIImage*) image fromViewCotroller: (UIViewController *) viewController;

@end
