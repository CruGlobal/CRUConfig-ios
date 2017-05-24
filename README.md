# CRUConfig

[![CI Status](http://img.shields.io/travis/CruGlobal/CRUConfig-ios.svg?style=flat)](https://travis-ci.org/CruGlobal/CRUConfig-ios)
[![Version](https://img.shields.io/cocoapods/v/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)
[![License](https://img.shields.io/cocoapods/l/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)
[![Platform](https://img.shields.io/cocoapods/p/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)

CRUConfig is an objc implementation of dotenv. It provides a wrapper to config.plist, giving you an easy way to get API keys and urls out of your code, while having your IDE autocomplete your values now that they will be properites instead of stings. It is also environment based so you can define different config files for different build configurations. (Not sure what a build configuration is, read [this](#what-are-build-configurations))

Once it picks the correct file for your environment it will automatically load that file's values into your config class, converting values to match your classes property types as it goes.

Read on to see how it works and how you can use it with your project. 

## Installation

CRUConfig is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CRUConfig"
```

## The Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Basic Usage

Create a subclass of `CRUEmptyConfig` and add your configuration values as properties.
The pod will automatically load values from your config file into the properties, including converting it to the correct type.
Check the sections below to find out how autoloading works, [autoloading rules](#autoloading-rules), and what to do if you have an exceptional case, [advanced loading](#advanced-loading).

In your subclass's header add the properties you would like to use in your code. e.g.
```objc
#import "CRUEmptyConfig.h"

@interface MYConfig : CRUEmptyConfig

@property (nonatomic, strong, readonly) NSURL		*baseUrl;
@property (nonatomic, strong, readonly) NSString	*myAPISecret;

@end
```

Use environment sepecific config value through your code
```objc
myAPI.baseURL = [MYConfig sharedConfig].baseURL;
```
OR
```objc
MYAPI *myAPI = [MYAPI apiWithConfig:[MYConfig sharedConfig]];
```

## Advanced Usage

### Loading Files Based on Build Configuration

Not sure what a build configuration is, read [this](#what-are-build-configurations)

The pod will look for a config file that matches the name of your current configuration.
e.g. If you are building your debug configuration it will look for config.debug.plist in your application bundle. If you build a target with your release configuration it will look for config.release.plist. If you create a custom configuration for your project called beta and your build uses that configuration then the pod will look for config.beta.plist. Note that they are alway in lowercase.

If you don't want to do configuration specific config files you can just use config.default.plist or config.plist.

The order of priority is as follows:
* config.{current build configuration name}.plist
* config.default.plist
* config.plist

All projects have at least 2 build configurations `Debug` and `Release`. If you create config files that match the current build configuration CRUConfig will attempt to load the associated plist file.

If your build uses a build configuration called `Adhoc` you should create a `config.adhoc.plist` file with your adhoc specific values like `base_url` as  `stage.api.example.com` then when you build your adhoc build all references to `[CRUConfig sharedConfig].baseURL` would reference your staging server. In your `config.release.plist` file you could then define `base_url` as `api.example.com` so now your release builds will automatically point at your production server.

You can create a config file for every build configuration in your project, even custom ones. If you don't use any of the build configuration specific config files the pod will fall back to `config.default.plist` or `config.plist`.

It will try to access the files in this order:

* The config file matching the current build configuration (e.g. `config.debug.plist`, always use lowercase in your filename, even if the configuration's name has capitals in the project)
* If there isn't a config file for the current build configuration it will try `config.default.plist`
* If `config.default.plist` doesn't exist it will try `config.plist`
* If none of these options exist it will return empty values

### Autoloading Rules

You will likely have need a variety of different configuration values in different type on every project you work on. To try and address this CRUConfig tries to match your plist keys with property names.

It will try to find a direct match then it will try to convert your plist key from snake case to camel case and look for a property that matches.
e.g.

| Plist Key | Property Name | Match |
| --- | --- | :---: |
| baseURL | baseURL | :white_check_mark: |
| my_super_secret | mySuperSecret | :white_check_mark: |
| base_url | baseUrl | :white_check_mark: |
| google_api_key | apiKeyGoogle | :x: |

Once it has found the property that matches the key it will attempt to convert the value to the property's type. The following are the rules for conversion. If the property can't be found or the value can't be converted or loaded then the plist entry is skipped and your property will be left with it's default value, usually nil.

| Plist Type | Possible Property Types | Notes |
| --- | --- | --- |
| `Array`         | `NSArray`, `NSSet`      |  |
| `Dictionary`    | `NSDictionary`          |  |
| `Boolean`       | `NSNumber`              |  |
| `Data`          | `NSData`, `NSString`    | Uses UTF8 encoding for conversion |
| `Date`          | `NSDate`, `NSString`    | Uses `yyyy-MM-dd HH:mm:ss zzz` date format for date conversions (can be changed by overriding dateFormat method in NSObject+PropertyTypeMatching category), if you want the date as a string the time zone defaults to GMT (which is the same as UTC but apple refuses to call it that. To change default timezone override the time zone method in NSObject+PropertyTypeMatching category) |
| `Number`        | `NSNumber`, `NSString`  | Uses the stringValue method on number for string conversion |
| `String`        | `NSString`, `NSURL`, `NSDate`, `NSData`, `NSNumber` | Uses UTF8 encoding for data conversion, Uses `yyyy-MM-dd HH:mm:ss zzz` date format for date conversions (can be changed by overriding dateFormat method in NSObject+PropertyTypeMatching category), Uses the double representation when storing the number in NSNumber |

Note that the only supported property types are NS Foundation types. If you need to load your values into a primative type or your values refuse to load look at the [Advanced Loading](#advanced-loading) section for ways to load those values manually.

e.g.
If this is your plist file
```XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>myAPISecret</key>
        <string>api-secret-1</string>
        <key>base_url</key>
        <string>localhost:8080</string>
    </dict>
</plist>
```

And this is your config class
```objc
#import "CRUEmptyConfig.h"

@interface MYConfig : CRUEmptyConfig

@property (nonatomic, strong, readonly) NSURL		*baseUrl;
@property (nonatomic, strong, readonly) NSString	*myAPISecret;
@property (nonatomic, strong, readonly) NSNumber    *loading;

@end
```

baseUrl would have an NSURL object with the address localhost:8080
myAPISecret would have an NSString

### Advanced loading

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

## What are build configurations

If you are not sure what a build configuration is, this article explains what they are [https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/BasingBuildConfigurationsonConfigurationFiles.html](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/BasingBuildConfigurationsonConfigurationFiles.html). If you are confused about why you would need a CRUConfig when you already have a build configuration. Build configurations let you define values and settings that are needed at build time and the values in CRUConfig are available during run time.

## Author

Harro, michael.harrison@cru.org

## License

CRUConfig is available under the MIT license. See the LICENSE file for more info.
