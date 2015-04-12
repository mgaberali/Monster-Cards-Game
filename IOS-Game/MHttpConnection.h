//
//  MHttpConnection.h
//  IOS-Game
//
//  Created by JETS on 4/12/15.
//  Copyright (c) 2015 Mad. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHttpConnection : NSObject{


    
}

+ (void)makeHttpRequestForUri:(NSString *)uri withMethod:(NSString *)method withParameters:(NSMutableDictionary *)parameters delegate:(id)delegate;

@end
