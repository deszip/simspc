//
//  SPSimListCommand.m
//  simspc
//
//  Created by Deszip on 17/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import "SPSimListCommand.h"

@implementation SPSimListCommand

- (instancetype)init {
    if (self = [super init]) {
        self.launchPath = @"/usr/bin/xcrun";
        self.arguments = @[@"simctl", @"list", @"--json"];
    }
    
    return self;
}

- (NSString *)handleResponse:(NSString *)response {
    NSError *serializationError = nil;
    NSDictionary *list = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&serializationError];
    if (!list) {
        NSLog(@"Failed to parse simctl response: %@", serializationError);
        return nil;
    }
    
    
    
    return response;
}

@end
