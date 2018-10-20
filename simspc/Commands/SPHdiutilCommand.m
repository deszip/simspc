//
//  SPHdiutilCommand.m
//  simspc
//
//  Created by Deszip on 20/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import "SPHdiutilCommand.h"

static NSString * const kImagePath = @"/tmp/1mb.dmg";

typedef NS_ENUM(NSUInteger, SPHdiutilTask) {
    SPHdiutilTaskUndefined = 0,
    
    SPHdiutilTaskCreateImage,
    SPHdiutilTaskAttachImage,
    SPHdiutilTaskInfo,
    SPHdiutilTaskDetachImage
};

@interface SPHdiutilCommand ()

@property (assign, nonatomic) SPHdiutilTask task;

@end

@implementation SPHdiutilCommand

- (instancetype)initWithArguments:(NSArray <NSString *> *)arguments task:(SPHdiutilTask)task {
    if (self = [super init]) {
        self.launchPath = @"/usr/bin/hdiutil";
        self.arguments = arguments;
        self.task = task;
    }
    
    return self;
}

+ (instancetype)createImage {
    if ([[NSFileManager defaultManager] fileExistsAtPath:kImagePath]) {
        NSError *error = nil;
        if (![[NSFileManager defaultManager] removeItemAtPath:kImagePath error:&error]) {
            NSLog(@"Failed to remove old image: %@", error);
            return nil;
        }
    }
    
    return [[SPHdiutilCommand alloc] initWithArguments:@[@"create", @"-size", @"1m", @"-fs", @"HFS+", kImagePath] task:SPHdiutilTaskCreateImage];
}

+ (instancetype)attachImage:(NSString *)mountPoint {
    return [[SPHdiutilCommand alloc] initWithArguments:@[@"attach", kImagePath, @"-mountpoint", mountPoint] task:SPHdiutilTaskAttachImage];
}

+ (instancetype)info {
    return [[SPHdiutilCommand alloc] initWithArguments:@[@"info", @"-plist"] task:SPHdiutilTaskInfo];
}

+ (instancetype)detach:(NSString *)diskName {
    return [[SPHdiutilCommand alloc] initWithArguments:@[@"detach", diskName] task:SPHdiutilTaskDetachImage];
}

- (id)handleResponse:(NSString *)response {
    if (self.task == SPHdiutilTaskInfo) {
        NSData *plistData = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSPropertyListFormat format;
        NSDictionary *info = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&format error:&error];
        if (info) {
            __block NSMutableArray *entries = [NSMutableArray array];
            [info[@"images"] enumerateObjectsUsingBlock:^(NSDictionary *imageInfo, NSUInteger idx, BOOL *stop) {
                if ([imageInfo[@"image-path"] isEqualToString:kImagePath]) {
                    [imageInfo[@"system-entities"] enumerateObjectsUsingBlock:^(NSDictionary *entity, NSUInteger idx, BOOL *stop) {
                        if (entity[@"mount-point"] && entity[@"dev-entry"]) {
                            [entries addObject:entity[@"dev-entry"]];
                        }
                    }];
                }
            }];
            
            return entries;
        }
    }

    return nil;
}

@end
