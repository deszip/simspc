//
//  SPCommandInteractor.m
//  simspc
//
//  Created by Deszip on 03/06/2018.
//  Copyright © 2018 Deszip. All rights reserved.
//

#import "SPCommandInteractor.h"

@interface SPCommandInteractor ()

@property (strong, nonatomic) NSTask *task;
@property (strong, nonatomic) NSPipe *pipe;

@end

@implementation SPCommandInteractor

- (id)launch:(id <SPCommand>)command {
    NSPipe *pipe = [NSPipe pipe];
    NSTask *task = [NSTask new];
    task.launchPath = [command launchPath];
    task.arguments = [command arguments];
    task.standardOutput = pipe;
    [task launch];
    [task waitUntilExit];

    NSFileHandle *outputHandle = pipe.fileHandleForReading;

    NSString *rawResponse = [[NSString alloc] initWithData:outputHandle.readDataToEndOfFile encoding:NSUTF8StringEncoding];
    NSString *parsedResponse = [command handleResponse:rawResponse];
    
    return parsedResponse;
}

@end
