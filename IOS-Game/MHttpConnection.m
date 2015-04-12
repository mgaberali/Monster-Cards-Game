//
//  MHttpConnection.m
//  IOS-Game
//
//  Created by JETS on 4/12/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import "MHttpConnection.h"

@implementation MHttpConnection


// you can define your server ip here
static NSString *SERVERIP = @"http://192.168.74.1:8084/";

+(void)makeHttpRequestForUri:(NSString *)uri withMethod:(NSString *)method withParameterString:(NSString *)parameter delegate:(id)delegate{
    
    
    // encode parameter data
    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    // get parameters length
    NSString *postLength = [NSString stringWithFormat:@"%d" , [parameterData length]];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    // set request url
    NSString *url = [SERVERIP stringByAppendingString:uri];
    [request setURL:[NSURL URLWithString:url]];
    
    // set request methods to post
    [request setHTTPMethod:method];
    
    // set request content length
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set paramters to http body
    [request setHTTPBody:parameterData];
    
    // set request content type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // create connection for the url
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];
    
    
    // start connection
    [connection start];

}

@end
