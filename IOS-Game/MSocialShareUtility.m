//
//  MSocialShareUtility.m
//  IOS-Game
//
//  Created by JETS on 4/3/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MSocialShareUtility.h"

@implementation MSocialShareUtility

/*
 * share score on facebook
 */
+ (void) sharePostOnFB: (NSString *) postString withLink: (NSString *) url withImage: (UIImage*) image fromViewCotroller: (UIViewController *) viewController{
    
    SLComposeViewController *controller = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
    SLComposeViewControllerCompletionHandler myBlock =
    ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled)
        {
            NSLog(@"Cancelled");
        }
        else
        {
            NSLog(@"Done");
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    controller.completionHandler = myBlock;
    //Adding the Text to the facebook post value from iOS
    [controller setInitialText:postString];
    //Adding the URL to the facebook post value from iOS
    [controller addURL:[NSURL URLWithString:url]];
    // Adding image to facebook post
    [controller addImage:image];
    //Adding the Text to the facebook post value from iOS
    [viewController presentViewController:controller animated:YES completion:nil];
    
}


@end
