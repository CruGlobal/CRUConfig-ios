#
# Be sure to run `pod lib lint CRUConfig.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CRUConfig"
  s.summary          = "CRUConfig is a wrapper to config.plist, prividing a easy way to get API keys out of your code."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.version          = "1.1.0"
  s.description      = <<-DESC
CRUConfig is a wrapper to config.plist, prividing a easy way to get API keys out of your code, while having your IDE check the spelling of your keys now that they will be properites instead of stings. It is also environment based so you can define different config files for different environments.

e.g. If you add `DEBUG=1` as a precompiler macro in one of your project's configurations CRUConfig would then attempt to load `config.debug.plist`. Which means if you defined `base_url` as `localhost` in `config.debug.plist` and `api.example.com` in `config.release.plist` your code would automatically switch which server it points to based on whether you hit the run button or the archive button in xcode.

The following pairs of enviroments and config files are available
(RELEASE, config.release.plist),
(ADHOC, config.adhoc.plist),
(DEBUG, config.debug.plist),
(PRODUCTION, config.production.plist),
(BETA, config.beta.plist),
(DEVELOPMENT, config.development.plist)
                       DESC

  s.homepage         = "https://github.com/CruGlobal/CRUConfig"
  s.license          = 'MIT'
  s.author           = { "Harro" => "michael.harrison@cru.org" }
  s.source           = { :git => "https://github.com/CruGlobal/CRUConfig.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'CRUConfig/Classes/**/*'

s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'CRUCONFIG_CURRENT_BUILD_CONFIGURATION=$(CONFIGURATION)' }

end
