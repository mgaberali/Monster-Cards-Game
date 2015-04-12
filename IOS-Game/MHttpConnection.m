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

+(void)makeHttpRequestForUri:(NSString *)uri withMethod:(NSString *)method withParameters:(NSMutableDictionary *)parameters delegate:(id)delegate{
    

    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    // set request url
    NSString *url = [SERVERIP stringByAppendingString:uri];
    [request setURL:[NSURL URLWithString:url]];
    
    // set request methods to post
    [request setHTTPMethod:method];
    
    //transform the dictionary key-value pair into NSData object
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONReadingMutableContainers error:nil];

    
    // set paramters to http body
    [request setHTTPBody:JSONData];
    
    // set request content type
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // create connection for the url
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];
    
    
    // start connection
    [connection start];

}

@end
