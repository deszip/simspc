//
//  SPSimListCommand.h
//  simspc
//
//  Created by Deszip on 17/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPSimListCommand : NSObject <SPCommand>

@property (copy, nonatomic) NSString *launchPath;
@property (copy, nonatomic) NSArray <NSString *> *arguments;

@end

NS_ASSUME_NONNULL_END
