//
//  CRUEmptyConfig.h
//  voke
//
//  Created by Michael Harrison on 2/8/16.
//  Copyright © 2016 Cru Global. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRUEmptyConfig : NSObject

/**
 *  The name of the build configuration in lowercase.
 *  e.g. If you build a target using the `Release` build configuration configurationName will be release
 */
@property (nonatomic, strong, readonly) NSString *configurationName;

+ (instancetype)sharedConfig;

@end
