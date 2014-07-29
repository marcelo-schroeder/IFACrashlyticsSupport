# IFACrashlyticsSupport #

A Cocoa Touch static library to make the most of the Crashlytics framework. It adds environment information that helps troubleshooting to crash reports such as system locale, current locale and preferred languages. It also makes it easier to add custom information to crash reports.
This library has been used in a few projects for my clients.

## How to install IFACrashlyticsSupport ##

The easiest is to add the source code as a Git submodule. Please follow the steps below (it assumes the use of an Xcode workspace):

1. Add the following URL to your project as a Git submodule: https://bitbucket.org/marcelo_schroeder/ifacrashlyticssupport.git
2. Add "IFACrashlyticsSupport.xcodeproj" to your Xcode workspace.
3. Add "libIFACrashlyticsSupport.a" to the "Build Phases"/"Link Binary With Libraries" section of your app's target.
4. In Xcode, add the following entry to "User Header Search Paths" in the "Build Settings" section of the desired target: "${PROJECT_DIR}/../submodules/IFACrashlyticsSupport/IFACrashlyticsSupport" (the actual location may vary and it will depend on where the Git submodule is in the file system). Set the entry to "recursive".

## How to use IFACrashlyticsSupport ##

In your application delegate, import "IFACrashlyticsSupportManager.h". Then, as the first thing in application:didFinishLaunchingWithOptions:, add the following line:


```
#!Objective-C
[[IFACrashlyticsSupportManager sharedInstance] configureCrashReportingWithUserInfo:nil];
```

You can also pass a user info dictionary containing key/value pairs that will be displayed along with the crash reports from Crashlytics. For further details, please refer to the API documentation in IFACrashlyticsSupportManager.h.