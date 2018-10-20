//
//  SPHdiutilCommand.h
//  simspc
//
//  Created by Deszip on 20/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPHdiutilCommand : NSObject <SPCommand>

@property (copy, nonatomic) NSString *launchPath;
@property (copy, nonatomic) NSArray <NSString *> *arguments;

- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)createImage;
+ (instancetype)attachImage:(NSString *)mountPoint;
+ (instancetype)info;
+ (instancetype)detach:(NSString *)diskName;

@end

NS_ASSUME_NONNULL_END
