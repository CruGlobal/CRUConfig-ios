//
//  CRUConfig.m
//  Pods
//
//  Created by Michael Harrison on 4/28/16.
//
//

#import "CRUConfig.h"
#import "CRUConfig+setter.h"

@implementation CRUConfig

- (void)setPropertiesWithContentsOfConfigDictionary:(NSDictionary *)configDictionary {
	
    [super setPropertiesWithContentsOfConfigDictionary:configDictionary];
    
	//set urls base on mode
	NSString *baseUrlString			= configDictionary[@"base_url"] ?: @"";
	_baseUrl						= [NSURL URLWithString:baseUrlString];
	
	//set api keys
	_apiKeyRollbar					= configDictionary[@"rollbar_client_api_key"] ?: @"";
	_apiKeyGoogleAnalytics			= configDictionary[@"google_analytics_api_key"] ?: @"";
	_apiKeyNewRelic					= configDictionary[@"newrelic_api_key"] ?: @"";
	
}

@end
