//
//  SPCommandInteractor.h
//  simspc
//
//  Created by Deszip on 03/06/2018.
//  Copyright © 2018 Deszip. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPCommand.h"

@interface SPCommandInteractor : NSObject

- (NSString *)launch:(id <SPCommand>)command;

@end
