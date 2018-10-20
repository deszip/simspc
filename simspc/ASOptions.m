//
//  ASOptions.m
//  aps-zstd
//
//  Created by Deszip on 12/06/2018.
//  Copyright © 2018 AppSpector. All rights reserved.
//

#import "ASOptions.h"

#import "XPMArguments.h"

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
    XPMArgumentSignature *mount = [XPMArgumentSignature argumentSignatureWithFormat:@"[-m --mount]"];
    XPMArgumentSignature *unmount = [XPMArgumentSignature argumentSignatureWithFormat:@"[-u --unmount]"];
    
    NSMutableArray *signatures = [NSMutableArray array];
    signatures[ASOptionIndexHelp] = help;
    signatures[ASOptionIndexVersion] = version;
    signatures[ASOptionIndexMount] = mount;
    signatures[ASOptionIndexUnmount] = unmount;
    
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
