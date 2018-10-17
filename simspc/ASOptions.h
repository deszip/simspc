//
//  ASOptions.h
//  aps-zstd
//
//  Created by Deszip on 12/06/2018.
//  Copyright © 2018 AppSpector. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASOptions : NSObject

- (instancetype)initWithArguments:(NSArray *)arguments;

- (BOOL)needHelp;
- (BOOL)needVersion;
- (BOOL)shouldPrintStats;
- (NSURL *)inputSessionFileURL;

@end
