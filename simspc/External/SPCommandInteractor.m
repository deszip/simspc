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

- (instancetype)init {
    if (self = [super init]) {
        _task = [NSTask new];
        _pipe = [NSPipe pipe];
    }
    
    return self;
}

- (NSString *)launch:(id <SPCommand>)command {
    self.task.launchPath = command.launchPath;
    self.task.arguments = command.arguments;
    self.task.standardOutput = self.pipe;
    [self.task launch];

    NSFileHandle *outputHandle = self.pipe.fileHandleForReading;

    NSString *rawResponse = [[NSString alloc] initWithData:outputHandle.readDataToEndOfFile encoding:NSUTF8StringEncoding];
    NSString *parsedResponse = [command handleResponse:rawResponse];
    
    return parsedResponse;
}

@end
