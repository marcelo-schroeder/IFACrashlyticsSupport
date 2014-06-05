platform :ios, '7.0'
workspace 'IFACrashlyticsSupport'
xcodeproj 'IFACrashlyticsSupport/IFACrashlyticsSupport.xcodeproj'
link_with 'IFACrashlyticsSupportTests'

#pod 'GustyLib', :path => '/Users/mschroeder/myfiles/projects/Xcode5/GustyLib/GustyLib_development'
pod 'GustyLib', :git => 'https://bitbucket.org/marcelo_schroeder/gustylib.git', :branch => 'dev_CrashlyticsSupportPodspec'

pod 'IFATestingSupport', :git => 'https://bitbucket.org/marcelo_schroeder/ifatestingsupport.git', :tag => '0.1.1'

# This pod is being to allow the project code to compile (the repo is mantained by a 3rd party).
# The Crashlytics framework (kept up to date by the Crashlytics Mac app) must be available in the client app.
pod 'CrashlyticsFramework'
