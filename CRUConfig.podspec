#
# Be sure to run `pod lib lint CRUConfig.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CRUConfig"
  s.version          = "1.1.0"
  s.summary          = "CRUConfig is an objc implementation of dotenv. It is a wrapper to config.plist, giving you an easy way to get API keys out of your code."
  s.description      = <<-DESC
CRUConfig is an objc implementation of dotenv. It provides a wrapper to config.plist, giving you an easy way to get API keys and urls out of your code, while having your IDE autocomplete your values now that they will be properites instead of stings. It is also environment based so you can define different config files for different environments.

The pod will look for a config file that matches the name of your current configuration.
e.g. If you are building your debug configuration it will look for config.debug.plist in your application bundle. If you build a target with your release configuration it will look for config.release.plist. If you create a custom configuration for your project called beta and your build uses that configuration then the pod will look for config.beta.plist. Note that they are alway in lowercase.

If you don't want to do configuration specific config files you can just use config.default.plist or config.plist.

The order of priority is as follows:
 * config.<current build configuration name>.plist
 * config.default.plist
 * config.plist
                       DESC

  s.homepage         = "https://github.com/CruGlobal/CRUConfig-ios"
  s.license          = 'MIT'
  s.author           = { "Harro" => "michael.harrison@cru.org" }
  s.source           = { :git => "https://github.com/CruGlobal/CRUConfig-ios.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'CRUConfig/Classes/**/*'

s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'CRUCONFIG_CURRENT_BUILD_CONFIGURATION=$(CONFIGURATION)' }

end
