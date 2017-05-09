//
//  MYAPI.m
//  CRUConfig
//
//  Created by Michael Harrison on 4/28/16.
//  Copyright © 2016 Harro. All rights reserved.
//

#import "MYAPI.h"

@implementation MYAPI

- (instancetype)initWithConfig:(CRUConfigDemoConfig *)config {
	
	self = [super init];
	if (!self) {
		return nil;
	}
	
	self.baseURL = config.baseUrl;
	
	return self;
}

@end
