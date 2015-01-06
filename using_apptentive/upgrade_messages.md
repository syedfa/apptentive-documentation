# Upgrade Messages

## Introduction

Upgrade Messages help you make sure your customers know about all of the latest and greatest changes in your app when you ship a new version.

## Instrumenting for Upgrade Messages

**NOTE**: Use of Upgrade Messages requires version 1.2.7 or above of the Apptentive iOS SDK, or version 1.3.0 of the SDK for Android.

For Upgrade Messages to function properly, you must ensure that the proper code point is included in your app's initialization. Further details are available in the [iOS Integration Documentation](http://www.apptentive.com/docs/ios/integration/) and the [Android Integration Documentation](http://www.apptentive.com/docs/android/integration/).

## Creating Upgrade Messages

To get started, create an Upgrade Message on the Apptentive website under the "Interactions" section. In addition to providing and styling the message itself, you'll have the opportunity to decide whether your app's icon is displayed and if you want the "Powered by Apptentive" banner to appear.

Upgrade Messages are targeted to a specific version or build (for Android).  To ensure that your Upgrade Message is displayed, you *must* provide the same version name or build number as what will appear in your App. On iOS this the value from `CFBundleShortVersionString` and is the version that appears in the App Store. On Android this is called the Version Name and is found in the manifest under `versionName`.

You can decide to publish your Upgrade Message immediately, or save it as a draft.  Note that once your Upgrade Message has been created, you can edit the message as well as the other settings, but you *may not* change the version or build that the Upgrade Message is targeted for.

## Upgrade Messages in App

If you've provided an Upgrade Message for a release of your app, it will be displayed at the code point you've instrumented for (typically app launch).

Upgrade Messages are only shown once for the given version and are only shown within the first week after someone upgrades. Finally, Upgrade Messages are only shown for upgrades-- if someone installs your app for the first time they will not see the Upgrade Message for that version.

## Testing Upgrade Messages

To test an Upgrade Message, you'll need to run a previous version of the app on your device and then "upgrade" to the version set in the Upgrade Message's configuration on the Apptentive Dashboard.

1. Create an Upgrade Message on the website. Target its version to "1.05" and use "upgrade_test" as its event.
2. Set app version to "1.04".
3. Reset device/simulator. Run app for ~30 seconds.
4. Quit app.
5. Set app version to "1.05". Also increment the "build" of your app.
6. You'll need to increment both the "version" (iOS: CFBundleShortVersionString) and "build" (iOS: CFBundleVersion) for it to be displayed.
7. Run the new version. Engage the event "upgrade_test" in code.
8. This should now trigger the upgrade message.

The key is to **upgrade** your app from one version to another. An Upgrade Message will never be shown for the first version of the app used on any particular device.