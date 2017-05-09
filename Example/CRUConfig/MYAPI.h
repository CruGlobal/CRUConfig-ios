//
//  MYAPI.h
//  CRUConfig
//
//  Created by Michael Harrison on 4/28/16.
//  Copyright © 2016 Harro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRUConfigDemoConfig.h"

@interface MYAPI : NSObject

@property (nonatomic, strong) NSURL *baseURL;

- (instancetype)initWithConfig:(CRUConfigDemoConfig *)config;

@end
