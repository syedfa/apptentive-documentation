### Get Apptentive

All of our client code is open source and [available on GitHub](https://github.com/apptentive/apptentive-ios).

#### Releases

We recommend integrating Apptentive as an Xcode subproject (see below) or by [using CocoaPods](http://www.apptentive.com/docs/ios/setup/cocoapods/).

However, the Apptentive iOS SDK's static library, header files, and resources bundle can be [downloaded from the project's GitHub Releases page](https://github.com/apptentive/apptentive-ios/releases).

These files can be used in the steps below to integrate Apptentive. You can ignore any directions to build the Apptentive files; they have already been built and provided for you.

New files are added for each official release of the iOS SDK. Please be sure to [watch our GitHub project](https://github.com/apptentive/apptentive-ios) and update your Apptentive library and resources in order to get the latest features and fixes.

#### Using Git

Clone our iOS SDK using git: `git clone https://github.com/apptentive/apptentive-ios.git`.

When the Apptentive submodule has finished cloning, add it as a subproject to your Xcode project or workspace.

### Add Apptentive as Xcode Subproject

Drag the `ApptentiveConnect.xcodeproj` project file (located in the `ApptentiveConnect` folder of our source code) into your Xcode project.

![ApptentiveConnect drag](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/ios/screenshots/iOS-apptentive-connect.png)

------------------------------------------------------------------------------------

### Required Frameworks

To use `ApptentiveConnect`, your project must link against the following frameworks:

* Accelerate
* AssetsLibrary
* CoreData
* CoreText
* CoreGraphics
* CoreTelephony
* Foundation
* QuartzCore
* StoreKit
* SystemConfiguration
* UIKit

*Note:* If your app uses Core Data and you listen for Core Data related notifications, you will
want to filter them based upon your managed object context. Learn more from [Apple's documentation](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/CoreDataFramework/Classes/NSManagedObjectContext_Class/NSManagedObjectContext.html).

##### Add required Frameworks

1. Select your Xcode project in the file navigator sidebar.
2. Select your Target, then its "Build Phases" tab.
3. Expand the "Link Binary With Libraries" build phase.
4. Add the frameworks listed above by clicking the `+` button.

![iOS Frameworks](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/ios/screenshots/iOS-frameworks.png)

### Add Linker Flags

1. Select your Xcode project in the file navigator sidebar.
2. Select your Project, then its "Build Settings" tab.
3. Search for the "Other Linker Flags" setting.
4. Double click the `Other Linker Flags` row's value area, on the right side. A pop-up should appear.
5. Add the following linker flags by pressing the "+" button:

```
    -ObjC -all_load
```

![iOS Linker Flags](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/ios/screenshots/iOS-linker-flags.png)

**Note:** If you can't use the `-all_load` flag in your project, you can use the `-force_load` flag instead:

```
    -force_load $(BUILT_PRODUCTS_DIR)/libApptentiveConnect.a
```

### Add Apptentive Library and Resources

##### Add Target Dependencies

1. Return to your Target's "Build Phases" tab.
2. Expand the "Target Dependencies" build phase.
3. Add `ApptentiveConnect` and `ApptentiveResources` as target dependencies.

![iOS Target Dependencies](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/ios/screenshots/iOS-target-dependencies.png)

##### Link Apptentive Library

1. Expand the "Link Binary With Libraries" build phase.
2. Click the "+" button and add `libApptentiveConnect.a`

![Apptentive Library](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/ios/screenshots/iOS-apptentive-library.png)

##### Build Apptentive Resources bundle

You should now build `ApptentiveResources.bundle`, the Apptentive assets bundle that will be added to your app.

1. In the upper left corner of your Xcode window, select the `Apptentive Resources` target from the scheme picker.
2. Select `iOS Device` as the build destination.
3. Select `Product > Build` from your Mace's menu bar.

**Note:** Build for an iOS Device, not the iOS Simulator, to work around an Xcode bug.

##### Copy Apptentive Resources bundle

1. Expand the ApptentiveConnect project in Xcode's file navigator.
2. Expand the `Products` directory. It should contain `ApptentiveResources.bundle`.
3. If the bundle's label is red, it must first be built. Follow the steps in the previous section.
3. In your Xcode Target's `Build Phases`, expand the `Copy Bundle Resources` build phase.
4. Drag `ApptentiveResources.bundle` from the `ApptentiveConnect` directory into the `Copy Bundle Resources` area.

![iOS Bundle Resources](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/ios/screenshots/iOS-bundle-resources.png)

### Add Apptentive header files

1. In the file navigator, expand the `source` directory of the ApptentiveConnect project.
2. Drag the file `ATConnect.h` out of the ApptentiveConnect project and into to your main project's files.

### Begin using Apptentive

You can now begin [using Apptentive in your project](http://www.apptentive.com/docs/ios/features/). For example, set your API key:  

```
#import "ATConnect.h"
...
[ATConnect sharedConnection].apiKey = @"abc_xyz_abc_xyz";
```

### Using Apptentive in a Swift Project

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

-
