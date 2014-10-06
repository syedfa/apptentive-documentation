# Integrating the Apptentive Android SDK

This document will show you how to integrate the Apptentive Android SDK into your app, configure it, and test to make
sure it's working properly. Each section lists the minimum necessary configuration, as well as optional steps.

# Download

The Apptentive Android SDK is open source. The project is located [here](https://github.com/apptentive/apptentive-android).

To download the SDK, either clone the SDK

`git clone https://github.com/apptentive/apptentive-android.git`

Or download the [latest release](https://github.com/apptentive/apptentive-android/releases).

### Keep Up To Date

We strive to fix bugs and add new features as quickly as possible. **Please watch our Github repo to stay up to date.**

# Setting up the Project

### Using Gradle

1. Modify your project's top-level settings.gradle to include a reference to the `apptentive-android/apptentive` directory.
    
    ```
    include 'apptentive'
    project(':apptentive').projectDir = new File('path-to-apptentive-repo/apptentive')
    ```
2. In your app's `build.gradle`, add a reference to this project.

    ```
    dependencies {
        compile project(':apptentive')
    }
    ```
3. If you are using IntelliJ IDEA or Android Studio, your IDE project settings should rebuild once you have made these modifications.

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

Integrate ALL of the Activities in your app with [ApptentiveActivity](http://www.apptentive.com/docs/android/api/index.html?com/apptentive/android/sdk/ApptentiveActivity.html).
You can mix and match, but make sure they all integrate in one of the following two ways.

1. **Inheritance**

    ```java
    import com.apptentive.android.sdk.ApptentiveActivity;

    public class ExampleActivity extends ApptentiveActivity {
    ```

2. **Delegation**

    ```java
    import com.apptentive.android.sdk.ApptentiveActivity;

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

The [Message Center](http://www.apptentive.com/docs/android/features/#message-center) is a self contained Activity that you can launch with [Apptentive.showMessageCenter(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#showMessageCenter%28anroid.app.Activity%29).

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

If you would like to be notified when a new message is sent to the client, register a listener using [Apptentive.setUnreadMessageListener(UnreadMessageListener listener)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setUnreadMessagesListener%28com.apptentive.android.sdk.module.messagecenter.UnreadMessagesListener%29).
When the number of unread messages changes, either because your customer read a message, or a new message came in, [onUnreadMessageCountChanged(int unreadMessages)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/messagecenter/UnreadMessagesListener.html#onUnreadMessageCountChanged%28int%29)
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

To add an **Event** and possibly show an **Interaction**, simply call [Apptentive.engage(Activity activity, String eventName)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#engage%28android.app.Activity,%20java.lang.String%29)
with an `eventName` of your choosing.

###### Example

Add an **Event** when your app's main Activity comes up.

```java
@Override
public void onWindowFocusChanged(boolean hasFocus) {
    super.onWindowFocusChanged(hasFocus);
    if (hasFocus) {
        // Engage a code point called "init".
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

**Apptentive** can send [push notifications](http://www.apptentive.com/docs/android/features/#push-notifications) to your app when you reply to your customers. Your replies are more likely to be seen by your customer when you do this. To set up push notifications, you will need to enter your push credentials on [apptentive.com](https://be.apptentive.com), send us the id that your push provider uses to identify the device, and call into our SDK when you receive and open a push notification.

### Supported Push Providers

* Urban Airship
* Amazon Web Services SNS
* Parse

### Configuring Your Push Credentials

To enter your push credentials, go to [apptentive.com](https://be.apptentive.com), select *Settings -> Integrations*,
choose *Urban Airship*, *Amazon Web Services SNS*, or *Parse*, and follow the instructions on that page.

### Setting the Device Token

In order for **Apptentive** to send push notifications to the correct device, you will need to pass us the device
identifier for the push provider you are using.

#### Setting the Urban Airship APID

The Urban Airship device ID is called *APID* (Airship Push ID). You can retreive it in one of two ways:

1. If you set up Urban Airship using a BroadcastReceiver to listen to Intents that Urban Airship sends you, you can
retreive the APID by listening for the Intent with action [PushManager.ACTION_REGISTRATION_FINISHED](http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/push/PushManager.html#ACTION_REGISTRATION_FINISHED),
grabbing the extra data [PushManager.EXTRA_APID](http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/push/PushManager.html#EXTRA_APID),
and passing it to [Apptentive.addUrbanAirshipPushIntegration(Context context, String apid](http://www.apptentive.com/docs/android/api/index.html?com/apptentive/android/sdk/ApptentiveActivity.html).

    ###### Example

    ```java
    String apid = intent.getStringExtra(PushManager.EXTRA_APID);
    Apptentive.addUrbanAirshipPushIntegration(context, apid);
    ```

    This method is preferable, because you will get the APID at the earliest possible time after the app is registered with
    UA, and will only need to give it to the Apptentive SDK once.

2. If you are not using a broadcast receiver, you can call [PushManager.getAPID()](http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/push/PushManager.html#getAPID%28%29).
This method may return null if Urban Airship hasn't finished registering, so don't give it to us until it returns an
actual APID.

    ###### Example

    ```java
    String apid = PushManager.getAPID();
    if (apid != null) {
      Apptentive.addUrbanAirshipPushIntegration(context, apid);
    }
    ```

#### Setting the Amazon Web Services SNS Registration ID

Amazon Web Services SNS uses GCM directly on the client, so you will need to use the GCM API to retreive the
Registration ID. See the [GCM documentation](http://developer.android.com/google/gcm/client.html) if you are unsure how
to retreive your Registration ID. When you have the Registration ID, pass it to [Apptentive.addAmazonSnsPushIntegration(Context context, String registrationId)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#addAmazonSnsPushIntegration%28android.content.Context,%20java.lang.String%29).

###### Example

```java
String registrationId;
Apptentive.addAmazonSnsPushIntegration(this, registrationId);
```

#### Setting up the Parse Device Token

Parse integration requires you to implement your own Application object. In the `onCreate()` method of your Application object, you will need to add the following code after your call to Parse.initialize(). This code will make sure that the deviceToken is sent to **Apptentive** as soon as it is registered with Parse.

```java
ParseInstallation parseInstallation = ParseInstallation.getCurrentInstallation();
if (parseInstallation == null || parseInstallation.get("deviceToken") == null) {
  ParseInstallation.getCurrentInstallation().saveInBackground(new SaveCallback() {
    @Override
    public void done(ParseException e) {
      String deviceToken = (String) ParseInstallation.getCurrentInstallation().get("deviceToken");
      Apptentive.addParsePushIntegration(getApplicationContext(), deviceToken);
    }
  });
} else {
  String deviceToken = (String) parseInstallation.get("deviceToken");
  Apptentive.addParsePushIntegration(this, deviceToken);
}
```

### Displaying a Push Notification from Parse

Parse requires you to call `PushService.setDefaultPushCallback()` so that Parse knows which of your Activities to launch when your customer opens a push notification. **Apptentive** needs to know this same information so that it can work seemlessly with your app. When you call `Apptentive.setParsePushCallback()`, you will most likely want to pass in the same Activity you passed to `PushService.setDefaultPushCallback()`. It also needs you to register our `ViewActivity` with Parse so that push notifications that came from **Apptentive** get handled by our code. All **Apptentive** push notifications will be sent to the Parse channel called `apptentive`.

In your `Application.onCreate()` method, add the following after your call to `PushService.setDefaultPushCallback()`:

```java
Apptentive.setParsePushCallback(YourActivity.class);
PushService.subscribe(this, "apptentive", ViewActivity.class);
```

### Displaying a Push Notification from all other providers

Opening an Apptentive push notification involves three easy steps: When the push notification is tapped by your customer,
pass it to [Apptentive.setPendingPushNotification(Context context, Intent intent)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setPendingPushNotification%28android.content.Context,%20android.content.Intent%29),
launch your main Activity, and display the push notification with [Apptentive.handleOpenedPushNotification(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#handleOpenedPushNotification%28android.app.Activity%29).
This two pass approach is necessary to avoid double displaying the push notification. Both of these methods do nothing
if the push notification didn't come from Apptentive.


###### Example

Push notification opened.

```java
Apptentive.setPendingPushNotification(context, intent);
// Then launch your main Activity.
```



In your main Activity, handle the push notification.

```java
@Override
public void onWindowFocusChanged(boolean hasFocus) {
  super.onWindowFocusChanged(hasFocus);
  if (hasFocus) {
    boolean ranApptentive = Apptentive.handleOpenedPushNotification(this);
    if (ranApptentive) {
      // Don't try to take any action here. Wait until the customer closes our UI.
      return;
    }
  }
}
```

##### Parse is a little Different

Parse integration is very simple. Because of this, you will need to create a `BroadcastReceiver` to intercept incoming notifications and pass them to Apptentive. Simple follow the steps below to do this.

1. Create a new class called ParsePushReceiver. Copy in and modify the code below to fit your package.

    ```java
    public class ParsePushReceiver extends BroadcastReceiver {
      @Override
      public void onReceive(Context context, Intent intent) {
        Apptentive.setPendingPushNotification(context, intent);
      }
    }
    ```

2. In your manifest, add the following right before the closing `</application>` element. Replace *com.apptentive.parse.example* with your package name.

    ```xml
    <receiver android:name="com.apptentive.parse.example.ParsePushReceiver" android:exported="false">
      <intent-filter>
        <action android:name="com.apptentive.PUSH"/>
      </intent-filter>
    </receiver>
    ```

3. Let Apptentive handle the push notification when it is opened. When you set up Parse, you most likely configured it to open an Activity when the push notification is opened by calling `PushService.setDefaultCallback(). In this Activity, you will want to allow Apptentive to handle the opened push notification. To do so, you will need to call `Apptentive.handleOpenedPushNotification()`. Here is the recommended implementation:

    ```java
    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
      super.onWindowFocusChanged(hasFocus);
      if (hasFocus) {
        Apptentive.handleOpenedPushNotification(this);
      }
    }
    ```

    Note that this method will return immediately if the push notification that was previously saved using `Apptentive.setPendingPushNotification()` did not come from Apptentive.

# Set Customer Email address

If you already know the customer's email address, you can pass it to us during initialization. Simple call [Apptentive.setInitialUserEmail(Context context, String email)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setInitialUserEmail%28android.content.Context,%20java.lang.String%29).

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

If you host your app in an app store other than Google Play, you will need to make sure customers who want to rate your app will be able to do so. To choose which app store the **Ratings Prompt Interaction** will take you to, we've built several **Rating Providers**. A **Rating Provider** is an implementation of the [IRatingProvider](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/IRatingProvider.html) interface, and its job is to provide a simple interface to open the app store. To use another supported [rating provider](http://www.apptentive.com/docs/android/features/#setting-rating-provider), you can make a call to [Apptentive.setRatingProvider(IRatingProvider ratingProvider)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setRatingProvider%28com.apptentive.android.sdk.module.rating.IRatingProvider%29). If you would like to use an app store that we don't yet support, you can implement the [IRatingProvider](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/IRatingProvider.html) interface, and pass your implementation to `setRatingProvider()`.

#### Supported Rating Providers

* [Google Play](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/impl/GooglePlayRatingProvider.html)
* [Amazon Appstore](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/impl/AmazonAppstoreRatingProvider.html)

###### Using the Amazon Appstore Rating Provider

```java
Apptentive.setRatingProvider(new AmazonAppstoreRatingProvider);
```

# Customizing the Look and Feel

Our SDK is 100% open source. If you wish to customize the look and feel of any UI componenets, you can do so directly.

Our [layouts](https://github.com/apptentive/apptentive-android/tree/master/apptentive-android-sdk/res/layout) and [styles](https://github.com/apptentive/apptentive-android/tree/master/apptentive-android-sdk/res/values) are stored in the Android standard `res` folder. Feel free to tweak colors, padding, fonts, etc.

We recommend that you fork our repo and check in your changes to this fork. This makes it easy to integrate new features and other changes that we add into your modified repo.
