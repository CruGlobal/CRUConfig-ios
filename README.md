# CRUConfig

[![CI Status](http://img.shields.io/travis/CruGlobal/CRUConfig.svg?style=flat)](https://travis-ci.org/CruGlobal/CRUConfig)
[![Version](https://img.shields.io/cocoapods/v/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)
[![License](https://img.shields.io/cocoapods/l/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)
[![Platform](https://img.shields.io/cocoapods/p/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)

CRUConfig is an objc implementation of dotenv. It provides a wrapper to config.plist, giving you an easy way to get API keys and urls out of your code, while having your IDE autocomplete your values now that they will be properites instead of stings. It is also environment based so you can define different config files for different build configurations. (Not sure what a build configuration is, read [this](#what-are-build-configurations))

The pod will look for a config file that matches the name of your current configuration.
e.g. If you are building your debug configuration it will look for config.debug.plist in your application bundle. If you build a target with your release configuration it will look for config.release.plist. If you create a custom configuration for your project called beta and your build uses that configuration then the pod will look for config.beta.plist. Note that they are alway in lowercase.

If you don't want to do configuration specific config files you can just use config.default.plist or config.plist.

The order of priority is as follows:
 * config.{current build configuration name}.plist
 * config.default.plist
 * config.plist

Read on to see how it works and how you can use it with your project. 

## Usage

Use environment sepecific config value through your code
```objc
myAPI.baseURL = [CRUConfig sharedConfig].baseURL;
```
OR
```objc
MYAPI *myAPI = [MYAPI apiWithConfig:[CRUConfig sharedConfig]];
```

###Loading Files Based on Build Configuration

Not sure what a build configuration is, read [this](#what-are-build-configurations)

All projects have at least 2 build configurations `Debug` and `Release`. If you create config files that match the current build configuration CRUConfig will attempt to load the associated plist file.

If your build uses a build configuration called `Adhoc` you should create a `config.adhoc.plist` file with your adhoc specific values like `base_url` as  `stage.api.example.com` then when you build your adhoc build all references to `[CRUConfig sharedConfig].baseURL` would reference your staging server. In your `config.release.plist` file you could then define `base_url` as `api.example.com` so now your release builds will automatically point at your production server.

You can create a config file for every build configuration in your project, even custom ones. If you don't use any of the build configuration specific config files the pod will fall back to `config.default.plist` or `config.plist`.

It will try to access the files in this order:

* The config file matching the current build configuration (e.g. `config.debug.plist`, always use lowercase in your filename, even if the configuration's name has capitals in the project)
* If there isn't a config file for the current build configuration it will try `config.default.plist`
* If `config.default.plist` doesn't exist it will try `config.plist`
* If none of these options exist it will return empty values

###Adding extra config values

You will likely have need more and/or different configuration values to the ones defined in `CRUConfig`. To add extra values, make a subclass of `CRUConfig`. If you don't like the defaults in `CRUConfig` you can make a subclass of `CRUEmptyConfig` and you can start from scratch (`CRUConfig` is actually a subclass of `CRUEmptyConfig`).

In your subclass's header add the properties you would like to use in your code. e.g.
```objc
#import "CRUEmptyConfig.h"

@interface MYConfig : CRUEmptyConfig

@property (nonatomic, strong, readonly) NSURL		*baseUrl;
@property (nonatomic, strong, readonly) NSString	*myAPISecret;

@end
```

Then in your `.m` file include the `CRUConfig+setter.h` file so that you can subclass the `- (void)setPropertiesWithContentsOfConfigDictionary:(NSDictionary *)configDictionary` method. Here you will be given a dictionary with the contents of the plist file that was loaded. In this method you should validate the value then set it to the correct property you created for your config value. Here is an example:

```objc
#import "CRUConfig.h"
#import "CRUConfig+setter.h"

@implementation CRUConfig

- (void)setPropertiesWithContentsOfConfigDictionary:(NSDictionary *)configDictionary {

    NSString *baseUrlString			= configDictionary[@"base_url"] ?: @"";
    _baseUrl						= [NSURL URLWithString:baseUrlString];

    _myAPISecret					= configDictionary[@"my_api_secret"] ?: @"";

}

@end
```

Now you can use the config class in your code
```objc
myAPI.baseURL = [CRUConfig sharedConfig].baseURL;
```
OR
```objc
MYAPI *myAPI = [MYAPI apiWithConfig:[CRUConfig sharedConfig]];
```

###What are build configurations

If you are not sure what a build configuration is, this article explains what they are [https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/BasingBuildConfigurationsonConfigurationFiles.html](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/BasingBuildConfigurationsonConfigurationFiles.html). If you are confused about why you would need a CRUConfig when you already have a build configuration. Build configurations let you define values and settings that are needed at build time and the values in CRUConfig are available during run time.

## Installation

CRUConfig is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CRUConfig"
```

##The Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Harro, michael.harrison@cru.org

## License

CRUConfig is available under the MIT license. See the LICENSE file for more info.
