### Get Apptentive

All of our client code is open source and available on GitHub](https://github.com/apptentive/apptentive-ios).

#### Using Git

You can clone our iOS SDK using git: `git clone https://github.com/apptentive/apptentive-ios.git`.

### Setup Xcode Project

First, drag the `ApptentiveConnect.xcodeproj` project file (located in the `ApptentiveConnect` folder of our source code) to your project in Xcode 5 and add it as a subproject.

![ApptentiveConnect drag](https://raw.github.com/apptentive/apptentive-ios/master/etc/screenshots/iOS-apptentive-connect.png)

------------------------------------------------------------------------------------

Next, in order to use `ApptentiveConnect`, your project must link against the
following frameworks:

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

##### How To

1. Click on your Xcode project in the file browser sidebar.
2. Go to your Xcode project's `Build Phases` tab.
3. Expand "Link Binary With Libraries".
4. Click on the `+` button and add the frameworks listed above.

![iOS Frameworks](https://raw.github.com/apptentive/apptentive-ios/master/etc/screenshots/iOS-frameworks.png)

#### Configure Apptentive

##### Setup Linker Flags

1. Click on your Xcode project in the file navigator sidebar.
2. Go to your Xcode project's `Build Settings` tab.
3. Search for `Other Linker Flags`
4. Double click in the blank area to the right of `Other Linker Flags` but under the "Yes" of `Link With Standard Libraries`
5. Click on the `+` button and add the following:

```
    -ObjC -all_load
```

![iOS Linker Flags](https://raw.github.com/apptentive/apptentive-ios/master/etc/screenshots/iOS-linker-flags.png)

**Note:** If you can't use the `-all_load` flag in your project, you can use the `-force_load` flag instead:

```
-force_load $(BUILT_PRODUCTS_DIR)/libApptentiveConnect.a
```

##### Add Apptentive Connect and Resources

1. Go back to your Xcode project's `Build Phases` tab.
2. Add the `ApptentiveConnect` and `ApptentiveResources` as targets in your project's `Target Dependencies`.

![iOS Target Dependencies](https://raw.github.com/apptentive/apptentive-ios/master/etc/screenshots/iOS-target-dependencies.png)

##### Link Apptentive Library

Under `Link Binary With Libraries`, add `libApptentiveConnect.a`.

![Apptentive Library](https://raw.github.com/apptentive/apptentive-ios/master/etc/screenshots/iOS-apptentive-library.png)

##### Build Apptentive Resources for iOS Devices

Building for iOS devices first works around a bug in Xcode 5.

1. In the upper left corner of your Xcode window, click on your project name in the scheme picker.
2. Select `Apptentive Resources`.
3. Click to the right of the arrow next to `Apptentive Resources`.
4. Select `iOS Devices`.
5. Under `Product` in your Mac's menu bar, click on `Build`.

##### Copy Apptentive Resources Bundle

1. In the file navigator, expand the ApptentiveConnect project.
2. Expand `Products`.
3. Under your Xcode project's `Build Phases`, expand `Copy Bundle Resources`.
4. Drag `ApptentiveResources.bundle` from the `ApptentiveConnect` products in the
file navigator into `Copy Bundle Resources`.

![iOS Bundle Resources](https://raw.github.com/apptentive/apptentive-ios/master/etc/screenshots/iOS-bundle-resources.png)

##### Add the ApptentiveConnect Header File

1. In the file navigator, expand `source` under the ApptentiveConnect project.
2. Drag `ATConnect.h` from `ApptentiveConnect.xcodeproj` to your app's file list.

-
