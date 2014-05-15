#### Using CocoaPods

Please note that if you use CocoaPods to integrate Apptentive, you can skip the "Setup Xcode Project" section and proceed directly to the ["Implement Apptentive in Project"](https://github.com/apptentive/apptentive-ios#implement-apptentive-in-project) directions below.

##### Create Podfile

1. Find [Apptentive's pod information](http://cocoapods.org/?q=apptentive-ios) on [CocoaPods](http://cocoapods.org).
2. List and save the dependencies in a text file named "Podfile" in your Xcode project directory. It should look something like this:

```
platform :ios, '6.0'
pod 'apptentive-ios'
```

##### Install Pods

Now you can install the dependencies in your project. Run this command in your Xcode project directory in Terminal:

```
$ pod install
```

-