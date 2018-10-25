//
//  ASOptions.m
//  aps-zstd
//
//  Created by Deszip on 12/06/2018.
//  Copyright © 2018 AppSpector. All rights reserved.
//

#import "ASOptions.h"

#import "NSString+Indenter.h"

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
    _helpArgument = [XPMArgumentSignature argumentSignatureWithFormat:@"[-h --help]"];
    _versionArgument = [XPMArgumentSignature argumentSignatureWithFormat:@"[-v --version]"];
    _mountArgument = [XPMArgumentSignature argumentSignatureWithFormat:@"[-m --mount]"];
    _unmountArgument = [XPMArgumentSignature argumentSignatureWithFormat:@"[-u --unmount]"];
    
    [_versionArgument setDescriptionHelper:^NSString *(XPMArgumentSignature *currentSignature, NSUInteger indentLevel, NSUInteger terminalWidth) {
        return [@"-v --version  Prints version." xpmargs_mutableStringByIndentingToWidth:indentLevel * 2 lineLength:terminalWidth];
    }];
    [_mountArgument setDescriptionHelper:^NSString *(XPMArgumentSignature *currentSignature, NSUInteger indentLevel, NSUInteger terminalWidth) {
        return [@"-m --mount  Mounts 1 mb image into booted simulator." xpmargs_mutableStringByIndentingToWidth:indentLevel * 2 lineLength:terminalWidth];
    }];
    [_unmountArgument setDescriptionHelper:^NSString *(XPMArgumentSignature *currentSignature, NSUInteger indentLevel, NSUInteger terminalWidth) {
        return [@"-u --unmount  Unmounts 1 mb image if any." xpmargs_mutableStringByIndentingToWidth:indentLevel * 2 lineLength:terminalWidth];
    }];
    
    NSMutableArray *signatures = [NSMutableArray array];
    signatures[ASOptionIndexHelp] = _helpArgument;
    signatures[ASOptionIndexVersion] = _versionArgument;
    signatures[ASOptionIndexMount] = _mountArgument;
    signatures[ASOptionIndexUnmount] = _unmountArgument;
    
    _signatures = [signatures copy];
}

- (BOOL)needHelp {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexHelp]];
}

- (BOOL)needVersion {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexVersion]];
}

- (BOOL)mount {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexMount]];
}

- (BOOL)unmount {
    return [self.package booleanValueForSignature:self.signatures[ASOptionIndexUnmount]];
}

@end
