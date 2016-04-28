//
//  CRUEmptyConfig.m
//  voke
//
//  Created by Michael Harrison on 2/8/16.
//  Copyright © 2016 Cru Global. All rights reserved.
//

#import "CRUEmptyConfig.h"
#import "CRUConfig+setter.h"

@implementation CRUEmptyConfig

+ (instancetype)sharedConfig {
	
	static id _sharedConfig;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		
		_sharedConfig					= [[self alloc] init];
		
	});
	
	return _sharedConfig;
	
}

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		NSString *configFileName		= @"config.release";
		
#ifdef DEBUG
		configFileName = @"config.debug";
#endif
		
#ifdef BETA
		configFileName = @"config.beta";
#endif
	
#ifdef PRODUCTION
		configFileName = @"config.production";
#endif
	
#ifdef DEVELOPMENT
		configFileName = @"config.development";
#endif
		
#ifdef ADHOC
		configFileName = @"config.adhoc";
#endif
		
#ifdef RELEASE
		configFileName = @"config.release";
#endif
		
		//read config file
		NSString *configFilePath		= [[NSBundle mainBundle] pathForResource:configFileName ofType:@"plist"];
		
		if (!configFilePath) {
			configFilePath		= [[NSBundle mainBundle] pathForResource:@"config.default" ofType:@"plist"];
		}
		
		if (!configFilePath) {
			configFilePath		= [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
		}
		
		NSDictionary *configDictionary	= [NSDictionary dictionaryWithContentsOfFile:configFilePath] ?: @{};
		
		[self setPropertiesWithContentsOfConfigDictionary:configDictionary];
		
	}
	
	return self;
}

- (void)setPropertiesWithContentsOfConfigDictionary:(NSDictionary *)configDictionary {
	
}

@end
