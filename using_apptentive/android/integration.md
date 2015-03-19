# Integrating the Apptentive Android SDK

This document will show you how to integrate the Apptentive Android SDK into your app, configure it, and test to make
sure it's working properly. Each section lists the minimum necessary configuration, as well as optional steps.

# Setting up the Project

### Integration From Maven Repository

Our SDK is avilable from the central Maven repo.

#### Using Gradle

Add a reference to the latest version of Apptentive in your app's `build.gradle`. Refer [here](http://search.maven.org/#browse|1536749708) to find the latest version.

###### Example
```
repositories {
  mavenCentral()
}

dependencies {
  compile 'com.apptentive:apptentive-android:1.7.1@aar'
}
```

If you are using IntelliJ IDEA or Android Studio, your IDE project settings should rebuild once you have made these modifications.

#### Using Maven

Add the following to your app's pom.xml in the `dependencies` element:

```xml
<dependency>
  <groupId>com.apptentive</groupId>
  <artifactId>apptentive-android</artifactId>
  <version>1.1.7</version>
</dependency>
```

## Integration From Source

The Apptentive Android SDK is open source. The project is located [here](https://github.com/apptentive/apptentive-android).

We strive to fix bugs and add new features as quickly as possible. **Please watch our Github repo to stay up to date.**

To download the SDK, either clone the SDK

`git clone https://github.com/apptentive/apptentive-android.git`

Or download the [latest release](https://github.com/apptentive/apptentive-android/releases).

### Using IntelliJ IDEA without Gradle

These instructions were tested with IntelliJ IDEA 14 EAP

1. From the menu bar, click `File` -> `Import Module`
2. Navigate to the `apptentive` directory that is contained in the `apptentive-android` repo
3. If your project uses Gradle, select `apptentive.iml`, otherwise choose `apptentive-without-gradle.iml`
4. From the menu bar, click `File` -> `Project Structure...`
5. Under `Project Settings` click `Modules`
6. Select the module for your Android app
7. Click the `Dependencies` tab, and then click the small `+` button in the lower left corner of that pane
8. Choose `Module Dependency...`, select `apptentive` module, and click `OK`
9. Click `OK` to save and close the settings

### Using Eclipse

These instructions were tested for the Eclipse Luna 4.4.0 release.

1. From the menu bar, click `File` -> `Import`
2. Under `General`, select `Existing Projects into Workspace`
3. Click `Next`
4. Under `Select root directory`, click `Browse…`
5. Select the folder `apptentive` that is contained in the `apptentive-android` repo
5. Click `Finish`
6. In the `Package Explorer`, select your android app's project
7. From the menu bar, click `Project` -> `Properties`
6. On the left side, click `Android`
7. Under the `Library` section, click `Add`
8. Select `apptentive`
9. Click `OK`

# Modifying your Manifest

You will need to make the following changes to your AndroidManifest.xml. Comments note the required and optional changes.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="com.apptentive.android.example"
          android:versionCode="1"
          android:versionName="1.0">
  <!-- Required -->
  <uses-permission android:name="android.permission.INTERNET"/>
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
  <!-- Optional - GET_ACCOUNTS is used to pre-populate customer's email in forms. -->
  <uses-permission android:name="android.permission.GET_ACCOUNTS"/>

  <!-- Make sure to support high resolution screens so Apptentive's UI looks great. -->
  <supports-screens android:largeScreens="true"
                    android:normalScreens="true"
                    android:smallScreens="true"
                    android:anyDensity="true"/>

  <!-- Your minSDKVersion is required to be at least 7. -->
  <uses-sdk android:minSdkVersion="7"
            android:targetSdkVersion="19"/>

  <application android:label="@string/app_name" android:icon="@drawable/icon">
    <activity android:name=".ExampleActivity"
              android:label="@string/app_name"
              android:configChanges="orientation|keyboardHidden"
              android:launchMode="singleTop">
      <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
      </intent-filter>
    </activity>

      <!-- The following is required -->
      <!-- Include your App's API key from Apptentive at "Settings -> API & Development" -->
      <meta-data android:name="apptentive_api_key" android:value="YOUR_API_KEY_GOES_HERE"/>
      <activity android:name="com.apptentive.android.sdk.ViewActivity"
                android:theme="@style/Apptentive.Theme.Transparent"/>
  </application>
</manifest>
```

**Note:** Be sure to input your Apptentive API Key where it says `YOUR_API_KEY_GOES_HERE`.

# Integrate your Activities with Apptentive

In order to keep track of Application state, we need to hook into the lifecycle of each Activity defined in your app.
There are two ways of doing this: *Inheritance* and *Delegation*. Inheritance is the easiest method, while delegation is
provided if you can't or don't want to inherit from our Activities.

Integrate ALL of the Activities in your app with Apptentive in one of the following two ways. You can mix and match, but make sure they all integrate Apptentive.

1. **Inheritance**

    ```java
    import com.apptentive.android.sdk.ApptentiveActivity;

    public class ExampleActivity extends ApptentiveActivity {
    ```

2. **Delegation**

    ```java
    import com.apptentive.android.sdk.Apptentive;

    ...

    @Override
    protected void onStart() {
      super.onStart();
      Apptentive.onStart(this);
    }

    @Override
    protected void onStop() {
      super.onStop();
      Apptentive.onStop(this);
    }
```

# Message Center

The [Message Center](http://www.apptentive.com/docs/android/features/#message-center) is a self contained Activity that you can launch with [Apptentive.showMessageCenter(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#showMessageCenter-android.app.Activity-).

You should find a place in your app where you can create a link or button that opens your **Message Center**.

###### Example

Here is how you can show **Message Center** by hooking it up to a button in your app.

```java
Button messageCenterButton = (Button)findViewById(R.id.your_message_center_button);
messageCenterButton.setOnClickListener(new View.OnClickListener(){
  public void onClick(View v) {
    Apptentive.showMessageCenter(YourActivity.this);
  }
});
```

### Send Custom Data With a Message (Optional)

Additionally, you can supply custom key/value pairs that will be sent in the next message that the customer sends while
**Message Center** is open. For instance, if you have a dining app, you could pass in a key of `restaurant` and value of
`Joe's Pizza`. If the customer sends a more than one message, only the first message will include this custom data. If
you wish to add more custom data to another subsequent message, you will need to call this method with custom data again.

###### Example

```java
Map<String, String> customData = new HashMap<String, String>();
customData.put("restaurant", "Joe's Pizza");
Apptentive.showMessageCenter(YourActivity.this, customData);
```

### New Message Notification (Optional)

If you would like to be notified when a new message is sent to the client, register a listener using [Apptentive.setUnreadMessageListener(UnreadMessageListener listener)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setUnreadMessagesListener-com.apptentive.android.sdk.module.messagecenter.UnreadMessagesListener-).
When the number of unread messages changes, either because your customer read a message, or a new message came in, [onUnreadMessageCountChanged(int unreadMessages)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/messagecenter/UnreadMessagesListener.html#onUnreadMessageCountChanged-int-)
will be called. Because this listener could be called at any time, you should store the value returned from this method,
and then perform any user interaction you desire at the appropriate time.

###### Example

```java
Apptentive.setUnreadMessagesListener(
  new UnreadMessagesListener() {
    public void onUnreadMessageCountChanged(final int unreadMessages) {
      // Use the updated count.
    }
  }
);
```

# Adding Events

You should add a handful of [Events](http://www.apptentive.com/docs/android/features/#events) to your app when you integrate. Since **Events** are both records of an action within your app being performed, and an opportunity to show an [Interaction](http://www.apptentive.com/docs/android/features/#interactions), you should choose places within your app that would be appropriate to interact with your customer, as well as places where a significant event has occured. The more **Events** you add during integration, the more you will learn about your customers, and the more fine tuned your communications with them can be. Here is a list of potential places to add **Events**.

Places where you might want to show an **Interaction**:
* Main Activity gains focus
* Settings Activity gains focus
* Customer performs an action that indicates they are confused
* There is a natural pause in the app's UI where starting a conversation would not interrupt the customer

Places where you might want to record a significant event:
* Customer makes a purchase
* Customer declines to make a purchase
* Customer beats a level
* Customer performs an action that indicates they know how to use your app
* Customer performs an action that indicates they are confused
* Your app crashes

As you can see, there is some overlap in whether you want to just record an **Event**, or also show an **Interaction**.

To add an **Event** and possibly show an **Interaction**, simply call [Apptentive.engage(Activity activity, String eventName)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#engage-android.app.Activity-java.lang.String-)
with an `eventName` of your choosing.

###### Example

Add an **Event** when your app's main Activity comes up.

```java
@Override
public void onWindowFocusChanged(boolean hasFocus) {
  super.onWindowFocusChanged(hasFocus);
  if (hasFocus) {
    // Engage a code point called "main_activity_focused".
    boolean shown = Apptentive.engage(this, "main_activity_focused");
  }
}
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

**Note**: **Upgrade Messages** are always targeted to the special `init` **Event**. You should trigger `init` at the first opportunity when your app starts up by calling `Apptentive.engage(this, "init")`.

**Note**: **Upgrade Messages** are only shown if the app is upgrading from a previous version. If you are installing a version of your app that has an **Upgrade Message** targeted to it, but it is not upgradeing from a previous version, the **Upgrade Message** will not be shown.

# Push Notifications

**Apptentive** can send [push notifications](http://www.apptentive.com/docs/android/features/#push-notifications) to your app when you reply to your customers. Your replies are more likely to be seen by your customer when you do this. To set up push notifications, you will need to enter your push credentials on [apptentive.com](https://be.apptentive.com), send us the id that your push provider uses to identify the device, and call into our SDK when a user opens a push notification.

#### Supported Push Providers

* Urban Airship (5.1.6)
* Amazon Web Services SNS
* Parse SDK 1.7.0+

## Configuring Apptentive to Work With Your Push Provider

### Configuring Your Push Credentials

To enter your push credentials, go to [apptentive.com](https://be.apptentive.com), select *Settings -> Integrations*,
choose *Urban Airship*, *Amazon Web Services SNS*, or *Parse*, and follow the instructions on that page.

### Using Urban Airship

#### Setting the Urban Airship Channel ID

First, make sure you have [integrated Urban Airship push notifications](http://docs.urbanairship.com/platform/android.html#urban-airship-sdk-setup) into your app.

Urban Airship creates a token called a *Channel ID* to identify each device. You will need to get the *Channel ID* and pass it to **Apptentive**.

First, you must make sure you are defining your own `IntentReceiver` that subclasses Urban Airship's [BaseIntentReceiver](http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/push/BaseIntentReceiver.html). You will need to follow the instructions in that link to add your `IntentReceiver` to your app's manifest. When you subclass `BaseIntentReceiver`, you will need to implement its abstract methods, including [onChannelRegistrationSucceeded()](http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/push/BaseIntentReceiver.html#onChannelRegistrationSucceeded%28android.content.Context,%20java.lang.String%29). Inside this method, you will need to pass the *Channel ID* to **Apptentive**.

[Apptentive.addUrbanAirshipPushIntegration(Context context, String channelId)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#addUrbanAirshipPushIntegration-android.content.Context-java.lang.String-)

###### Example

```java
@Override
protected void onChannelRegistrationSucceeded(Context context, String channelId) {
	Apptentive.addUrbanAirshipPushIntegration(context, channelId);
}
```

#### Saving the Urban Airship Push Notification with Apptentive

Urban Airship's `BaseBroadcastReceiver` also requires you to implement the abstract method [onNotificationOpened()](http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/push/BaseIntentReceiver.html#onNotificationOpened%28android.content.Context,%20com.urbanairship.push.PushMessage,%20int%29). Inside this method, you will need to pass Apptentive the extra Bundle from teh opened push notification. If this push notificaiton came from Apptentive, we will save the data it contains. Otherwise, it will have no effect.

[Apptentive.setPendingPushNotification(Context context, Intent intent)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setPendingPushNotification-android.content.Context-android.content.Intent-)

###### Example

```java
@Override
protected boolean onNotificationOpened(Context context, PushMessage pushMessage, int i) {
	Apptentive.setPendingPushNotification(context, pushMessage.getPushBundle());
	return false;
}
```

#### Displaying an Urban Airship Push Notification

You will either choose an Activity to launch when the push notification is opened, or by default let your MainActivity handle the opened push notification. Either way, you will need to give Apptentive a chance to display the push notification. If there is no saved push notification, this method will have no effect.

[Apptentive.handleOpenedPushNotification(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#handleOpenedPushNotification-android.app.Activity-)

###### Example

Allowing Apptentive to handle the push notification when your Activity gains focus is a good practice.

```java
@Override
public void onWindowFocusChanged(boolean hasFocus) {
	super.onWindowFocusChanged(hasFocus);
	if (hasFocus) {
		boolean ranApptentive = Apptentive.handleOpenedPushNotification(this);
	}
}
```

### Using Parse

#### Setting the Parse Device Token

First, make sure you have [integrated Parse push notifications](https://www.parse.com/tutorials/android-push-notifications) into your app.

Parse integration requires you to implement your own `Application` object. In the `onCreate()` method of your `Application` object, you will need to read the `deviceToken` from Parse, and pass it to Apptentive. Apptentive sends pushes to Parse in the `apptentive` channel. The following code assumes you are using the latest Parse SDK, and registering it to receive push notifications sent to the `apptentive` channel. In the `done()` method of your `SaveCallback`, you must read the `deviceToken`, and pass it to Apptentive.

[Apptentive.addParsePushIntegration(Context context, String deviceToken)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#addParsePushIntegration-android.content.Context-java.lang.String-)

###### Example

```java
ParsePush.subscribeInBackground("apptentive", new SaveCallback() {
	@Override
	public void done(ParseException e) {
		if (e == null) {
			String deviceToken = (String) ParseInstallation.getCurrentInstallation().get("deviceToken");
			Apptentive.addParsePushIntegration(getApplicationContext(), deviceToken);
		}
	}
});
```
#### Saving the Parse Push Notification with Apptentive

Integrating **Parse** into your app involves adding a receiver entry in your manifest that points to `com.parse.ParsePushBroadcastReceiver`. This receiver will receive `Intents` when a user opens a push notification. In order to enable **Apptentive** to receive push notifications that are meant for us, you will need to subclass `ParsePushBroadcastReceiver` and replace the reference in your manifest to point to your subclass. Then, add the following in your subclass's `onPushOpen()` method.

[Apptentive.setPendingPushNotification(Context context, Intent intent)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setPendingPushNotification-android.content.Context-android.content.Intent-)

###### Example

```java
@Override
protected void onPushOpen(Context context, Intent intent) {
	super.onPushOpen(context, intent);
	Apptentive.setPendingPushNotification(context, intent);
}
```

#### Displaying a Push Notification from Parse

This previous step allows Apptentive to save a copy of the data that we sent in the push. If the push didn't come from **Apptentive**, this method has no effect. Next, you will need to tell **Apptentive** when it is appropriate to act on the push notification. By default, **Parse** will launch your default `Activity` when a user opens the push notification. Where you call **Apptentive** will depend on how you have build your app, but a good place is inside `onWindowFocusChanged()`.

[Apptentive.handleOpenedPushNotification(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#handleOpenedPushNotification-android.app.Activity-)

###### Example

```java
@Override
public void onWindowFocusChanged(boolean hasFocus) {
  super.onWindowFocusChanged(hasFocus);
  if (hasFocus) {
    // Returns true if the push notification was for Apptentive, and we handled it.
    boolean ranApptentive = Apptentive.handleOpenedPushNotification(this);
  }
}
```

### Using Amazon SNS

#### Setting the Amazon Web Services SNS GCM Registration ID

**Amazon Web Services SNS** uses **GCM** directly on the client, so you will need to use the **GCM** API to retreive the
*Registration ID*. See the [GCM documentation](http://developer.android.com/google/gcm/client.html) if you are unsure how
to retreive your *Registration ID*. When you have the *Registration ID*, pass it to **Apptentive**.

[Apptentive.addAmazonSnsPushIntegration(Context context, String registrationId)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#addAmazonSnsPushIntegration-android.content.Context-java.lang.String-)

###### Example

```java
String registrationId;
Apptentive.addAmazonSnsPushIntegration(this, registrationId);
```

#### Saving the Amazon SNS / GCM Push Notification with Apptentive

Opening an **Apptentive** push notification involves two easy steps: When the push notification is tapped by your customer,
pass it to **Apptentive**.

[Apptentive.setPendingPushNotification(Context context, Intent intent)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setPendingPushNotification-android.content.Context-android.content.Intent-)

###### Example

```java
@Override
public void onReceive(Context context, Intent intent) {
	Apptentive.setPendingPushNotification(context, intent);
}
```

#### Displaying a Push Notification from Amazon SNS / GCM

You must then launch one of your Activities. In that Activity, call Apptentive to display the push notification. A good place to do this is when your Activity gains focus. This method has no effect if the push notification is not from Apptentive.

[Apptentive.handleOpenedPushNotification(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#handleOpenedPushNotification-android.app.Activity-)

###### Example

```java
@Override
public void onWindowFocusChanged(boolean hasFocus) {
	super.onWindowFocusChanged(hasFocus);
	if (hasFocus) {
		boolean ranApptentive = Apptentive.handleOpenedPushNotification(this);
	}
}
```

# Set Customer Contact Information

If you already know the customer's email address, you can pass it to us during initialization. Simply call [Apptentive.setInitialUserEmail(Context context, String email)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setInitialUserEmail-android.content.Context-java.lang.String-).

If you know their name, and would like to see it displayed when you are communicating with them through the Apptentive dashboard, call [Apptentive.setInitialUserName(Context context, String name)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setInitialUserName-android.content.Context-java.lang.String-).

# Custom Data

You can send [Custom Data](http://www.apptentive.com/docs/android/features/#custom-data) associated with either the device, or the person using the app. This is useful for sending user IDs and other information that helps you support your users better. **Custom Data** can also be used for configuring when [Interactions](http://www.apptentive.com/docs/android/features/#interactions) will run. For best results, call this during `onCreate()`.

###### Example

Send the user ID of your customer.

```java
Apptentive.addCustomPersonData(this, "1234567890");
```

# Attachments

You can send [hidden messages and attachments](http://www.apptentive.com/docs/android/features/#sending-hidden-messages-and-attachments) to Apptentive that will show up in your customer conversation view on [apptentive.com](https://be.apptentive.com), but are not shown to your customer.

###### Example

```java
// Send a file.
InputStream is = new FileInputStream("filePath");
Apptentive.sendAttachmentFile(this, is);

// Send a text message.
Apptentive.sendAttachmentText(this, "Message to display in the conversation view.");
```

# Setting Rating Provider

If you host your app in an app store other than Google Play, you will need to make sure customers who want to rate your app will be able to do so. To choose which app store the **Ratings Prompt Interaction** will take you to, we've built several **Rating Providers**. A **Rating Provider** is an implementation of the [IRatingProvider](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/IRatingProvider.html) interface, and its job is to provide a simple interface to open the app store. To use another supported [rating provider](http://www.apptentive.com/docs/android/features/#setting-rating-provider), you can make a call to [Apptentive.setRatingProvider(IRatingProvider ratingProvider)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setRatingProvider-com.apptentive.android.sdk.module.rating.IRatingProvider-). If you would like to use an app store that we don't yet support, you can implement the [IRatingProvider](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/IRatingProvider.html) interface, and pass your implementation to `setRatingProvider()`.

#### Supported Rating Providers

* [Google Play](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/impl/GooglePlayRatingProvider.html)
* [Amazon Appstore](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/impl/AmazonAppstoreRatingProvider.html)

###### Using the Amazon Appstore Rating Provider

```java
Apptentive.setRatingProvider(new AmazonAppstoreRatingProvider());
```

# Customizing the Look and Feel

Please see our [Customization Guide](http://www.apptentive.com/docs/android/customization/) for more information.

# Logging
During development, Apptentive may log a considerable amount of information to logcat. This data is logged `VERBOSE` and `DEBUG` level. When the app is not built for developement, we stop logging all `VERBOSE` and `DEBUG` level information. If you would like to limit the amount of logging you see from Apptentive while you are in development, simply add the following element to your manifest inside the `<application>` element. Set the value to one of these strings: `VERBOSE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, or `ASSERT`.

```xml
<!-- This will prevent VERBOSE and DEBUG level logging. -->
<meta-data android:name="apptentive_log_level" android:value="INFO"/>
```
