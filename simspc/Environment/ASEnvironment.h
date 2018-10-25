//
//  ASEnvironment.h
//  simspc
//
//  Created by Deszip on 23/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASOptions.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASEnvironment : NSObject

- (void)printHelp:(ASOptions *)options;
- (void)printVersion;

- (void)toStdout:(NSString *)output;
- (void)toStderr:(NSString *)output;

@end

NS_ASSUME_NONNULL_END
