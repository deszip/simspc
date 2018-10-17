//
//  ASOptions.m
//  aps-zstd
//
//  Created by Deszip on 12/06/2018.
//  Copyright © 2018 AppSpector. All rights reserved.
//

#import "ASOptions.h"

#import "XPMArguments.h"
#import "NSString+backSlashes.h"

typedef NS_ENUM(NSUInteger, ASOptionIndex) {
    ASOptionIndexHelp = 0,
    ASOptionIndexVersion,
    ASOptionIndexMount,
    ASOptionIndexUnmount
};

@interface ASOptions ()

@property (strong, nonatomic) NSArray <XPMArgumentSignature *> *signatures;
@property (strong, nonatomic) XPMArgumentPackage *package;

@end

@implementation ASOptions

- (instancetype)initWithArguments:(NSArray *)arguments {
    if (self = [super init]) {
        [self buildSignatures];
        XPMArgumentParser *parser = [[XPMArgumentParser alloc] initWithArguments:arguments signatures:_signatures];
        _package = [parser parse];
    }
    
    return self;
}

- (void)buildSignatures {
    XPMArgumentSignature *help = [XPMArgumentSignature argumentSignatureWithFormat:@"[-h --help]"];
    XPMArgumentSignature *version = [XPMArgumentSignature argumentSignatureWithFormat:@"[-v --version]"];
    XPMArgumentSignature *inputSessionURL = [XPMArgumentSignature argumentSignatureWithFormat:@"[-i --input]={1,1}"];
    XPMArgumentSignature *stats = [XPMArgumentSignature argumentSignatureWithFormat:@"[-s --stats]"];
    
    NSMutableArray *signatures = [NSMutableArray array];
    signatures[ASOptionIndexHelp] = help;
    signatures[ASOptionIndexVersion] = version;
    signatures[ASOptionIndexInputSessionURL] = inputSessionURL;
    signatures[ASOptionIndexSessionStats] = stats;
    _signatures = [signatures copy];
}

- (BOOL)needHelp {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexHelp]];
}

- (BOOL)needVersion {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexVersion]];
}

- (BOOL)shouldPrintStats {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexSessionStats]];
}

- (NSURL *)inputSessionFileURL {
    NSString *sessionPath = [[self.package firstObjectForSignature:self.signatures[ASOptionIndexInputSessionURL]] stringByExpandingTildeInPath];
    if (!sessionPath) {
        return nil;
    }
    
    NSURL *sessionURL = [NSURL fileURLWithPath:sessionPath];
    
    return sessionURL;
}

@end
