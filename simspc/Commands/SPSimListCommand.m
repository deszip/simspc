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

- (NSArray <NSString *> *)handleResponse:(NSString *)response {
    NSError *serializationError = nil;
    NSDictionary *list = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&serializationError];
    if (!list) {
        NSLog(@"Failed to parse simctl response: %@", serializationError);
        return nil;
    }
    
    NSDictionary *devcices = list[@"devices"];
    __block NSMutableArray *bootedUDIDs = [NSMutableArray array];
    [devcices enumerateKeysAndObjectsUsingBlock:^(NSString *runtime, NSArray *simulators, BOOL *stop) {
        [simulators enumerateObjectsUsingBlock:^(NSDictionary *simulator, NSUInteger idx, BOOL *stop) {
            if ([simulator[@"state"] isEqualToString:@"Booted"]) {
                [bootedUDIDs addObject:simulator[@"udid"]];
            }
        }];
    }];
    
    return [bootedUDIDs copy];
}

@end
