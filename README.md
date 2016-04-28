# CRUConfig

[![CI Status](http://img.shields.io/travis/CruGlobal/CRUConfig.svg?style=flat)](https://travis-ci.org/CruGlobal/CRUConfig)
[![Version](https://img.shields.io/cocoapods/v/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)
[![License](https://img.shields.io/cocoapods/l/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)
[![Platform](https://img.shields.io/cocoapods/p/CRUConfig.svg?style=flat)](http://cocoapods.org/pods/CRUConfig)

CRUConfig is a wrapper to config.plist, prividing a easy way to get API keys out of your code, while having your IDE check the spelling of your keys now that they will be properites instead of stings. It is also environment based so you can define different config files for different environments.

e.g. If you add `DEBUG=1` as a precompiler macro in one of your project's configurations CRUConfig would then attempt to load `config.debug.plist`. Which means if you defined `base_url` as `localhost` in `config.debug.plist` and `api.example.com` in `config.release.plist` your code would automatically switch which server it points to based on whether you hit the run button or the archive button in xcode.

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

###Loading Files Based on configuration

If you add any of the following as a precompiler macro in a build configuration (or as a `#define` statement although `#define` is not recommended) CRUConfig will attempt to load the associated plist file.

If you define `ADHOC` as a precompiler macro you should create a `config.adhoc.plist` file with your adhoc specific values like `base_url` as  `stage.api.example.com` then when you build your adhoc build all references to `[CRUConfig sharedConfig].baseURL` would reference your staging server. In your config.release.plist file you could then define `base_url` as `api.example.com` so now your release builds will automatically point at your production server.

The following pairs are available:
```
(RELEASE, config.release.plist)
(ADHOC, config.adhoc.plist)
(DEBUG, config.debug.plist)
(PRODUCTION, config.production.plist)
(BETA, config.beta.plist)
(DEVELOPMENT, config.development.plist)
```

Feel free to use any combination of them. If you don't use any it will fall back to config.default.plist or config.plist.

It will try to access the files in this order:

* The config file matching the current environment (the order of list above shows the order of importance if multiple enviroments are defined during any one build)
* If none are defined it will try config.release.plist
* If release doesn't exist it will try config.default.plist
* If default doesn't exist it will try config.plist
* If none of these options exist it will return empty values

###Adding extra config values

You will likely have need more and/or different configuration values to the ones defined in `CRUConfig`. To add extra values, make a subclass of `CRUConfig`. If you hate the defaults in `CRUConfig` you can make a subclass of `CRUEmptyConfig` and you can start from scratch (`CRUConfig` is actually a subclass of `CRUEmptyConfig`).

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

## Installation

CRUConfig is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CRUConfig"
```

###Adding Environment definitions to project configurations

Instead of adding `#define ADHOC` into your code you can have your project inject them into your build via your build's configuration. Here is how you do that:

Select your project file > Select your target > Select `Build Settings` > Search for `preprocessor`

It should look like this
![Build Settings](https://www.evernote.com/l/AF-trO4euXREHov8CWQRUmDVvue_S-FheyAB/image.png)

Now under `Precompiler Macros` double click on the configuration you want to edit (for this example I'm editing Release) > Hit the `+` button in the bottom left corner of the popup > Type in the definition you would like to have injected. The #define part should be left off (for this example `RELEASE=1`)

It should look like this
![Precompiler Macros](https://www.evernote.com/l/AF9WsqOy0iFFeK-30RO8hQF6PUhdxj5oDGoB/image.png)

Now we can create a config.release.plist file and CRUConfig (and its subclasses) will read from it when you make a build using the release configuration.

If you want to add additional configurations for doing adhoc releases or other forms of QA follow this tutorial [Adding Build Configurations](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/BasingBuildConfigurationsonConfigurationFiles.html)

##The Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Harro, michael.harrison@cru.org

## License

CRUConfig is available under the MIT license. See the LICENSE file for more info.
