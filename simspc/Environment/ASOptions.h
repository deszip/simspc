//
//  ASOptions.h
//  aps-zstd
//
//  Created by Deszip on 12/06/2018.
//  Copyright © 2018 AppSpector. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XPMArguments.h"
#import "XPMArgumentSignature.h"

@interface ASOptions : NSObject

@property (strong, nonatomic, readonly) XPMArgumentSignature *helpArgument;
@property (strong, nonatomic, readonly) XPMArgumentSignature *versionArgument;
@property (strong, nonatomic, readonly) XPMArgumentSignature *mountArgument;
@property (strong, nonatomic, readonly) XPMArgumentSignature *unmountArgument;

- (instancetype)initWithArguments:(NSArray *)arguments;

- (BOOL)needHelp;
- (BOOL)needVersion;
- (BOOL)mount;
- (BOOL)unmount;

@end
