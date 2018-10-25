//
//  ASEnvironment.m
//  simspc
//
//  Created by Deszip on 23/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import "ASEnvironment.h"

#include <sys/ioctl.h>
#import "XPMArguments.h"
#import "XPMArgumentSignature.h"


@interface ASEnvironment ()

@property (strong, nonatomic) NSFileHandle *stdoutHandle;
@property (strong, nonatomic) NSFileHandle *stderrHandle;

@end

@implementation ASEnvironment

- (instancetype)init {
    if (self = [super init]) {
        _stdoutHandle = [NSFileHandle fileHandleWithStandardOutput];
        _stderrHandle = [NSFileHandle fileHandleWithStandardError];
    }
    
    return self;
}

- (void)printHelp:(ASOptions *)options {
    struct winsize ws;
    ioctl(0, TIOCGWINSZ, &ws);
    
    [self toStdout:@"Tool to simulate lack of disk space in iOS simulators.\n\n"];
    [self toStdout:[NSString stringWithFormat:@"%@\n", [options.versionArgument descriptionForHelpWithIndent:2 terminalWidth:ws.ws_col]]];
    [self toStdout:[NSString stringWithFormat:@"%@\n", [options.mountArgument descriptionForHelpWithIndent:2 terminalWidth:ws.ws_col]]];
    [self toStdout:[NSString stringWithFormat:@"%@\n", [options.unmountArgument descriptionForHelpWithIndent:2 terminalWidth:ws.ws_col]]];
    [self toStdout:@"\n(C) 2018 by Deszip. All your base are belong to me.\n"];
}

- (void)printVersion {
    [self toStdout:@"0.0.1\n"];
}

#pragma mark - Output -

- (void)toStdout:(NSString *)output {
    [self.stdoutHandle writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)toStderr:(NSString *)output {
    [self.stderrHandle writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
