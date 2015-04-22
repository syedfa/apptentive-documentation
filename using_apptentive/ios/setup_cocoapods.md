#### Using CocoaPods

The Apptentive iOS SDK is available via CocoaPods, a dependency manager for Objective-C.

http://cocoapods.org/

##### Create project Podfile

Your Podfile controls the dependencies that CocoaPods installs in your Xcode project:  

1. Create a text file named "Podfile" in your Xcode project directory.
2. Find [Apptentive's pod information](http://cocoapods.org/?q=apptentive-ios) on [CocoaPods](http://cocoapods.org).
3. Add the Apptentive dependency to your Podfile. It should look something like this:

```
platform :ios, '7.0'
pod 'apptentive-ios'
```

##### Install the Apptentive Pod

When the Apptentive dependency has been listed in your Podfile, run the Terminal command `pod install` in your Xcode project directory:

```
$ pod install
```

If all goes well, you should see:

 > [!] From now on use `YourProject.xcworkspace`.

CocoaPods has created an Xcode Workspace containing your original project plus a project containing Apptentive your other project dependencies.

##### Begin using Apptentive

After running `pod install`, open the newly created Xcode Workspace.

You can now begin [using Apptentive in your project](http://www.apptentive.com/docs/ios/features/). For example, set your API key:  

```
#import "ATConnect.h"
...
[ATConnect sharedConnection].apiKey = @"abc_xyz_abc_xyz";
```

##### Using Apptentive in a Swift Project

An additional step is needed to use the Apptentive SDK in a Swift project: the Swift compiler requires a special file (called an *Objective-C Bridging Header*) to allow Objective-C code to be called from Swift code.

If your project already has an Objective-C Bridging Header, skip to the last step. Otherwise you will need to create a new header file and configure the build settings for your target so that the compiler can find it.

1. Create a new file (File > New > File…) and choose Header File as the type (in the Source group under iOS or OS X). Xcode's convention is to name the file `ProductName-Bridging-Header.h` (replacing `ProductName` with the Product Name build setting for your target).
2. Go to your target's build settings under Swift Compiler - Code Generation, and add the path to the header file you just created (for example, `$(SRCROOT)/$(PRODUCT_NAME)/ProductName-Bridging-Header.h`).
3. Edit your bridging header and add the following lines (before the `#endif` line):

```
#import <UIKit/UIKit.h>
#import "ATConnect.h"
```

The `ATConnect` class will now be available for use in your Swift source files.
