//
//  SPCommand.h
//  simspc
//
//  Created by Deszip on 17/10/2018.
//  Copyright © 2018 SimSpace. All rights reserved.
//

#ifndef SPCommand_h
#define SPCommand_h

@protocol SPCommand <NSObject>

@required
@property (copy, nonatomic) NSString *launchPath;
@property (copy, nonatomic) NSArray <NSString *> *arguments;

- (id)handleResponse:(NSString *)response;

@end

#endif /* SPCommand_h */
