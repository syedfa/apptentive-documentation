# Integrating the Apptentive Cordova SDK Plugin

This document will show you how to integrate the Apptentive Cordova SDK Plugin into your app, configure it, and test to make
sure it's working properly. Each section lists the minimum necessary configuration, as well as optional steps.

# Requirements

## Supported platforms

This Cordova Plugin wraps our native SDKs. The complete descriptions for the features contained in our SDKs are located here:

* [Android](https://www.apptentive.com/docs/android/integration/)
* [iOS](https://www.apptentive.com/docs/ios/integration/)

## Registering Apps

You will need to create an app on https://be.apptentive.com for each of the platforms you wish to use Apptentive on. Even though there is a single plugin for Cordova that works on both Android and iOS, you will need to create a separate Android and iOS app on our website.

Once you have created an Android and iOS app, you will need to access both of their API Keys at _**Settings -> API & Development**_.

# Adding the Plugin to Your App

Our plugin is hosted in a [Github repo](https://github.com/apptentive/apptentive-cordova). Installation is easy, and involves pointing at our repo and passing in both of the API Keys you got from the previous step.

```
cordova plugin add https://github.com/apptentive/apptentive-cordova.git --variable ANDROID_API_KEY="your_android_api_key" --variable IOS_API_KEY="your_ios_api_key"
```

**Note: Do not use the same API Key for Android and iOS.*

If you need to remove this plugin in the future, it can easily be removed with the following command:

```
cordova plugin remove com.apptentive.cordova
```

# Required Integration

You may use any of the features of our SDK listed below, but the following section is required.

You will need to give Apptentive access to your app's Cordova lifecycle events. Below is a simple example of this minimum integration.

```javascript
var app = {
    initialize: function() {
        document.addEventListener('deviceready', app.onDeviceReady, false);
    },
    onDeviceReady: function() {
        document.addEventListener('resume', app.onResume, false);
        document.addEventListener('pause', app.onPause, false);
        Apptentive.deviceReady(app.successLogger, app.errorAlert);
    },
    onResume: function() {
        Apptentive.resume(app.successLogger, app.errorAlert);
    },
    onPause: function() {
        Apptentive.pause(app.successLogger, app.errorAlert);
    }
}
app.initialize();
```

This example accomplishes three things
* Registers for the **deviceready** cordova event
* Hooks Apptentive into the **deviceready** event, and registers for the **pause** and **resume** events
* Hooks Apptentive into the **pause** and **resume** events

# Message Center

The Message Center is a messaging UI that allows you to talk to your customer.

* Android
* iOS

You should find a place in your app where you can create a link or button that opens your **Message Center**.

###### Example

```javascript
    Apptentive.showMessageCenter(successCallback, failureCallback);
}
```

### Send Custom Data With a Message (Optional)

Additionally, you can supply custom key/value pairs that will be sent in the next message that the customer sends while
**Message Center** is open. For instance, if you have a dining app, you could pass in a key of `restaurant` and value of
`Joe's Pizza`. If the customer sends a more than one message, only the first message will include this custom data. If
you wish to add more custom data to another subsequent message, you will need to call this method with custom data again.

###### Example

```javascript
    Apptentive.showMessageCenter(successCallback, failureCallback, {"key": "value"});
}
```

### New Message Notification (Optional)

You can be notified any time the number of unread messages in Message Center changes, by registering a listener when your device finishes initializing. You can add this next to your existing call to _Apptentive.deviceReady();_

```javascript
    Apptentive.setUnreadMessagesListener(function(int){});
```
The listener function you pass in will be passed an integer when it is called.
    
###### Example
```javascript
    onDeviceReady: function() {
        document.addEventListener('resume', app.onResume, false);
        document.addEventListener('pause', app.onPause, false);
        Apptentive.deviceReady(app.successLogger, app.errorAlert);
        Apptentive.setUnreadMessagesListener(
            function(unreadMessages) {
                console.log("UnreadMessages: " + unreadMessages);
            }
        );
    }
```

# Adding Events

You should add a handful of [Events](http://www.apptentive.com/docs/android/features/#events) to your app when you integrate. Since **Events** are both records of an action within your app being performed, and an opportunity to show an [Interaction](http://www.apptentive.com/docs/android/features/#interactions), you should choose places within your app that would be appropriate to interact with your customer, as well as places where a significant event has occured. The more **Events** you add during integration, the more you will learn about your customers, and the more fine tuned your communications with them can be. Here is a list of potential places to add **Events**.

Places where you might want to show an **Interaction**:
* The app opens
* Settings view gains focus
* Customer performs an action that indicates they are confused
* There is a natural pause in the app's UI where starting a conversation would not interrupt the customer

Places where you might want to record an Event:
* Customer makes a purchase
* Customer declines to make a purchase
* Customer beats a level
* Customer performs an action that indicates they know how to use your app
* Customer performs an action that indicates they are confused
* Your app crashes

As you can see, there is some overlap in whether you want to just record an **Event**, or also show an **Interaction**.

To add an **Event** and possibly show an **Interaction**, simply call **Apptentive.engage(eventName)**
with an `eventName` of your choosing.

###### Example

```javascript
    Apptentive.engage("myEventName");
```

**Note:** Each **Event** should have a unique name.


# Configure Interactions

Once you have configured your app to use several **Events**, you can configure **Interactions** on [apptentive.com](https://be.apptentive.com)

#### Ratings Prompt

To set up the [Ratings Prompt](http://www.apptentive.com/docs/android/features/#ratings-prompt) **Interaction**, first make sure you have [create a few Events](#adding-events) in your app. Then, go to *Interactions -> Ratings Prompt*. In the tab labeled *The Prompt*, you can customize the text and behavior of the dialogs that make up the **Ratings Prompt**. The *Targeting* tab lets you create user segments that will see the **Ratings Prompt**, as well as define the conditions necessary for the **Ratings Prompt** to display. You will also need to pick which **Event** will display the **Ratings Prompt** will be shown, by entering an **Event** name in the *Where* section of that page.

#### Surveys

[Surveys](http://www.apptentive.com/docs/android/features/#surveys) can also be configured from the server. First, make sure you have [created some Events](#adding-events), then go to *Interactions -> Surveys*. Create a new survey. You can give it a title and description, then add questions, and finally set targeting and limiting constraints so it's shown to the right people. After your survey is live, you will start to see results in the *Surveys* page.

**Note:** If you were using surveys prior to version 1.5.0 of the Apptentive Android SDK, see this [Migration Guide] (https://github.com/apptentive/apptentive-android/blob/master/docs/migrating_to_1.5.0.md) for instructions.

#### Upgrade Messages

When you release a new version of your app, you should create an [Upgrade Message](http://www.apptentive.com/docs/android/features/#upgrade-messages) to tell your customers what's new. To do so, go to *Interactions -> Upgrade Messages*. You can use the editor to write out details about this release, and then target the message to display when a customer upgrades your app to a specific [version name or code](http://developer.android.com/tools/publishing/versioning.html).

**Note**: **Upgrade Messages** are only shown if the app is upgrading from a previous version. If you are installing a version of your app that has an **Upgrade Message** targeted to it, but it is not upgradeing from a previous version, the **Upgrade Message** will not be shown.

# Push Notifications

Push notifications are not currently supported in our Cordova Plugin. If you are interested in using push notifications to let your customers know when you reply to their feedback, please drop us a line at [support@apptentive.com](email:support@apptentive.com)

# Set Customer Contact Information

If you already know the customer's email address, you can pass it to us during initialization. Simply call 

```javascript
Apptentive.setInitialUserEmail(email);
```

If you know their name, and would like to see it displayed when you are communicating with them through the Apptentive dashboard, call

```javascript
Apptentive.setInitialUserName(name);
```

# Custom Data

You can send [Custom Data](http://www.apptentive.com/docs/android/features/#custom-data) associated with either the device, or the person using the app. This is useful for sending user IDs and other information that helps you support your users better. **Custom Data** can also be used for configuring when [Interactions](http://www.apptentive.com/docs/android/features/#interactions) will run.

```javascript
Apptentive.addCustomDeviceData(key, value);
```

```javascript
Apptentive.addCustomPersonData(key, value);
```

# Attachments

Our native SDKs support sending attachments to our server. This is useful for sending logs and other artifacts that help you understand customer issues. This is not currently supported in the Cordova Plugin, but if you are interested in this feature, please let us know at [support@apptentive.com](email:support@apptentive.com)

# Setting Rating Provider

If you are deploying your Cordova app to Amazon's Appstore instead of Google Play, you will need to use the following function. Pass in the string **"amazon"**. If you publish your app with Google Play, this step is not necessary.

```javascript
Apptentive.setRatingProvider("amazon");
```
