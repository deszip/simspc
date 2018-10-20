//
//  main.m
//  simspc
//
//  Created by Deszip on 17/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASOptions.h"
#import "SPCommandInteractor.h"
#import "SPSimListCommand.h"
#import "SPHdiutilCommand.h"

/*
 1
 xcrun simctl list --json
    - find booted sim under "devices" key
    - if UUID passed - search for it, boot if not booted
 
 2
 hdiutil create -size 1m -fs HFS+ /tmp/1meg.dmg
    optionally get size and FS from arguments
 
 3
 hdiutil attach /tmp/1meg.dmg -mountpoint /Users/zardoz/Library/Developer/CoreSimulator/Devices/5E973C4A-8823-4A5F-9478-45263B9EBA42/data/Containers/Data/Application/foo
    use simulator UUID to build mount point path
 
 4
 hdiutil info -plist
    find device from step 2 by name, get it mountpoint
 
 5
 hdiutil detach disk2s1
    detach using mountpoint from step 4
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ASOptions *options = [[ASOptions alloc] initWithArguments:[[NSProcessInfo processInfo] arguments]];
        
        if ([options needHelp]) {
            // show help...
            return EXIT_SUCCESS;
        }
        
        if ([options needVersion]) {
            NSLog(@"0.0.1");
            return EXIT_SUCCESS;
        }
        
        SPCommandInteractor *interactor = [SPCommandInteractor new];
        NSArray *simulators = [interactor launch:[SPSimListCommand new]];
        NSLog(@"Booted simulators: %@", simulators);
        
        if (simulators.count == 0) {
            return EXIT_FAILURE;
        }
        
        if ([options mount]) {
            [interactor launch:[SPHdiutilCommand createImage]];
            NSString *mountPoint = [NSString stringWithFormat:@"%@/Library/Developer/CoreSimulator/Devices/%@/data/Containers/Data/Application/foo", NSHomeDirectory(), simulators[0]];
            [interactor launch:[SPHdiutilCommand attachImage:mountPoint]];
            
            return EXIT_SUCCESS;
        }
        
        if ([options unmount]) {
            NSArray *mountedEntries = [interactor launch:[SPHdiutilCommand info]];
            NSLog(@"Mounted entries: %@", mountedEntries);
            
            [mountedEntries enumerateObjectsUsingBlock:^(NSString *entry, NSUInteger idx, BOOL *stop) {
                [interactor launch:[SPHdiutilCommand detach:entry]];
            }];
            
            return EXIT_SUCCESS;
        }
    }
    
    return EXIT_SUCCESS;
}
