//
//  CRUConfig.h
//  Pods
//
//  Created by Michael Harrison on 4/28/16.
//
//

#import "CRUEmptyConfig.h"

@interface CRUConfig : CRUEmptyConfig

@property (nonatomic, strong, readonly) NSURL		*baseUrl;
@property (nonatomic, strong, readonly) NSString	*apiKeyRollbar;
@property (nonatomic, strong, readonly) NSString	*apiKeyGoogleAnalytics;
@property (nonatomic, strong, readonly) NSString	*apiKeyNewRelic;

@end
