//
//  CRUConfigDemoConfig.h
//  CRUConfig
//
//  Created by Michael Harrison on 5/8/17.
//  Copyright © 2017 Harro. All rights reserved.
//

#import <CRUConfig/CRUEmptyConfig.h>

@interface CRUConfigDemoConfig : CRUEmptyConfig

@property (nonatomic, strong) NSURL *baseUrl;
@property (nonatomic, strong) NSString *myApiKey;
@property (nonatomic, assign) BOOL myAPISecret;

@end
