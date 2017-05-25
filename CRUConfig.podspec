#
# Be sure to run `pod lib lint CRUConfig.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CRUConfig"
  s.version          = "1.2.0"
  s.summary          = "CRUConfig is an objc implementation of dotenv. It is a wrapper to config.plist, giving you an easy way to get API keys out of your code."
  s.description      = <<-DESC
CRUConfig is an objc implementation of dotenv. It provides a wrapper to config.plist, giving you an easy way to get API keys and urls out of your code, while having your IDE autocomplete your values now that they will be properites instead of stings. It is also environment based so you can define different config files for different build configurations. (Not sure what a build configuration is, read [this](#what-are-build-configurations))

Once it picks the correct file for your environment it will automatically load that file's values into your config class, converting values to match your classes property types as it goes.
                       DESC

  s.homepage         = "https://github.com/CruGlobal/CRUConfig-ios"
  s.license          = 'MIT'
  s.author           = { "Harro" => "michael.harrison@cru.org" }
  s.source           = { :git => "https://github.com/CruGlobal/CRUConfig-ios.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'CRUConfig/Classes/**/*'

s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'CRUCONFIG_CURRENT_BUILD_CONFIGURATION=$(CONFIGURATION)' }

end
