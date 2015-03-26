# Apptentive Android SDK Features

The Apptentive Android SDK gives you a simple but powerful channel to communicate with your customers. With it, you can
manage your app's ratings, let your customers give you feedback, respond to customer feedback, show surveys at specific
points within your app, and more.

# System Requirements

### SDK Versions

**Minimum SDK version:** 7 (Android 2.1)

**Build SDK version:** 12 (3.1)

The Apptentive SDK works on devices with **Android SDK 2.1 (API Level 7)** and newer. You must also build your app
against **Android SDK 3.1 (API 12)** or newer. This will not cause your app to stop working on pre-3.1 devices, but
allows us to use newer XML syntax for forward compatibility.

### SDK Size

Our SDK is very small. It will add **250k - 300k** to the size of your app.
###Supported Languages

| Locale Qualifier | Language Name |
| ---------------- | ------------- |
| None             |  English      |
| `ar`             |  Arabic       |
| `el`             |  Greek        |
| `da`             |  Danish       |
| `de`             |  German       |
| `es`             |  Spanish      |
| `fr`             |  French       |
| `fr-rCA`         |  French Canadian |
| `it`             |  Italian      |
| `ja`             |  Japanese     |
| `ko`             |  Korean       |
| `nl`             |  Dutch        |
| `pt`             |  Brazilian Portuguese |
| `ru`             |  Russian      |
| `sv`             |  Swedish      |
| `tr`             |  Turkish      |
| `zh`             |  Chinese (Traditional) |
| `zh-rCN`         |  Chinese (Simplified)  |


# Events and Interactions

Our SDK lets you keep track of customer behavior, and initiate conversations with each customer based on their behavior.
**Interactions** are the UI elements that you use to interact with each customer, and **Events** are records of past
customer behavior.

### Events

**Events** are records of actions taken in your app. What constitutes an **Event** is up to you. For example, you may
choose to keep track of each time a user has logs into your app, the app crashes, or they pass a level. **Events** are
stored on the client, and can be used to determine when and where to show **Interactions**. Your app should contain at
least five **Events**. The more **Events** you define in your app, the more useful the **Apptentive SDK** will
be.

**Events** are invoked using the
[Apptentive.engage()](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#engage-android.app.Activity-java.lang.String-) method.
When your app invokes an **Event**, it will be sent to our server. It will show up on [apptentive.com](https://be.apptentive.com)
under **_Interactions -> Events_**, so you can verify that **Events** are making it to our server. If you would like to
predefine an **Event** name so that you can use it in an **Interaction** before you make any changes on the client, you
can do so by entering it manually on that page as well.

### Interactions

**Interactions** are views that you can use to easily and proactively start conversations with your customers. You
configure their content, the conditions necessary to show them, and the **Event** that should trigger them. The
Apptentive SDK takes care of fetching them, evaluating the logic they contain, and displaying them. Each **Interaction**
is configured on the server, so you can easily add or modify them after you've released your app, without modifying the
source code. **Interactions** are displayed using the same
[Apptentive.engage()](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#engage-android.app.Activity-java.lang.String-)
method as **Events**, which is why adding several **Events** to your app during development is important. It allows you
to configure an **Interaction** to display at the **Event** of your choosing after you have shipped your app. The difference
between an **Event** and an **Interaction** is that an **Event** is a record of the `engage()` method being called,
while an **Interaction** is a view or group of views that is displayed when `engage()` is called.

##### Supported Interactions
* [Ratings Prompt](#ratings-prompt)
* [Surveys](#surveys)
* [Upgrade messages](#upgrade-messages)

**Interactions** can be configured on [apptentive.com](https://be.apptentive.com) by clicking the *Interactions*
link in the top bar.

**Note:** Interactions are fetched automatically by our SDK and cached locally for 24 hours.

## Ratings Prompt

The **Ratings Prompt Interaction** is a powerful tool to help you get better ratings and more reviews from happy
customers, and start conversations with customers who have feedback, suggestions, or critiques. The **Ratings Prompt**
is actually a series of views. The inital view is called the *Enjoyment Dialog*, and ask the customer whether they love
your app. If the answer is yes, then they are shown the *Rating Dialog*, which offers them the oportunity to go to the
app store to rate the app. If they don't love your app, they will be taken to the [Message Center](#message-center) where
they can give you feedback.

[Setting up the Ratings Prompt](http://www.apptentive.com/docs/android/integration/#ratings-prompt)

![Enjoyment Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/enjoyment_dialog.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Rating Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/rating_dialog.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Intro Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/intro_dialog_sorry_blank.png)

![Using Custom Events](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/ratings_prompt_interaction_config.png)

## Surveys

**Surveys** are **Interactions** that help you understand the wants and needs of your customers. **Surveys** are
composed of one or more questions, and since they are **Interactions**, can be targeted to any **Event** you have
configured in your app. There are three supported question types: *Single Select*, *Multiple Select*, and *Free Form*.

[Setting up a Survey](http://www.apptentive.com/docs/android/integration/#surveys)

![Survey Incomplete](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/survey_incomplete.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Survey Complete](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/survey_complete.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Survey Complete](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/survey_thank_you.png)

![Using Custom Events](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/survey_interaction_config.png)

## Upgrade Messages

Many customers choose to have their apps automatically update. While this is convenient for them, it mean they often
won't see announcements or release notes that you display on your app store page. **Upgrade Messages** solve this
problem. You can configure an **Upgrade Message** for each release of your app. When the user upgrades from a previous
version of your app to one of the targeted versions, whey will see the **Upgrade Message**.

[Setting up an Upgrade Message](http://www.apptentive.com/docs/android/integration/#upgrade-messages)

![Using Custom Events](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/upgrade_message_interaction_config.png)

**Note**: **Upgrade Messages** are always targeted to the special `init` **Event**. You should trigger `init` at
the first opportunity when your app starts up by calling `Apptentive.engage(this, "init")`.

# Message Center

With the **Apptentive Message Center** you and your customers talk directly without making them leave your app. Handling
support inside the app will increase the number of support messages received and ensure a better customer experience.

If the **Message Center** is being opened for the first time, the *Intro Dialog* will be shown instead. When the customer
submits the *Intro Dialog*, they are taken to a *Thank You Dialog*, where they have a chance to open the
**Message Center**.

[Setting up Message Center](http://www.apptentive.com/docs/android/integration/#message-center)

![Intro Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/intro_dialog_default_blank.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Intro Dialog Completed](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/intro_dialog_default_filled.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Thank You Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/thank_you_dialog.png)

The Message Center displays all messages sent between you and your customer. Your replies will show up in the Message
Center, and the customer will not have to leave your app to see them. Customers with devices running Android 4+ will
also be able to send screenshots.

![Message Center Sent](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/message_center_default_sent.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Message Center Screenshot Sent](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/message_center_default_screenshot_sent.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Message Center Reply Received](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/message_center_default_reply_received.png)

Here is what the other side of the conversation looks like.

![Website Conversation View](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/website_conversation_default_reply.png)

The Apptentive Android SDK checks for new messages every **60 seconds** while your app is running. When **Message Center**
is open, it checks every **8 seconds**, in order to provide lower latency. Messages sent from the client are sent
immediately.

### Displaying Message Center

The **Message Center** is displayed by calling [Apptentive.showMessageCenter(Activity activity)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#showMessageCenter-android.app.Activity-).

### Passing Custom Data on Messages

Additionally, you can supply custom key/value pairs that will be sent in the next message that the customer sends while
the **Message Center** is open. For instance, if you have a dining app, you could pass in a key of `restaurant` and
value of `Joe's Pizza`.

If the customer sends more than one message, only the first message will include this custom
data. If you wish to add more custom data to another subsequent message, you will need to call this method with custom
data again. When the message is sent to [apptentive.com](https://be.apptentive.com), it will have this custom data
attached to help you understand what yoru customer was doing when they decided to send feedback.

[Apptentive.showMessageCenter(Activity activity, Map<String, String> customData)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#showMessageCenter-android.app.Activity-java.util.Map-).

### New Message Notifications

You can also receive a notification when the number of unread messages waiting to be viewed by the customer changes.

[Apptentive.setUnreadMessageListener(UnreadMessageListener listener)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setUnreadMessagesListener-com.apptentive.android.sdk.module.messagecenter.UnreadMessagesListener-)

### Checking Unread Message Count

You can also check to see how many messages are waiting to be read in the customer's **Message Center**.

[Apptentive.getUnreadMessageCount(Context context)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#getUnreadMessageCount-android.content.Context-)

### Sending Hidden Messages and Attachments

You can also send hidden messages from the app that will show up in your convesation on [apptentive.com](https://be.apptentive.com).
They won't be visible to the customer, but you can send file and text messages that help fill in details about the state
of the app, so you can better support your customers.

#### Sending File Attachments

* [Apptentive.sendAttachmentFile(Context context, byte&#91;&#93; data, String mimeType)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#sendAttachmentFile-android.content.Context-byte:A-java.lang.String-)
* [Apptentive.sendAttachmentFile(Context context, InputStream is, String mimeType)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#sendAttachmentFile-android.content.Context-java.io.InputStream-java.lang.String-)
* [Apptentive.sendAttachmentFile(Context context, String Uri)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#sendAttachmentFile-android.content.Context-java.lang.String-)

#### Sending Hidden Text Messages

* [Apptentive.sendAttachmentText(Context context, String text)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#sendAttachmentText-android.content.Context-java.lang.String-)

# Miscellaneous

## Setting Rating Provider

By default, the Ratings Prompt will open the Google Play app store. You can force the Ratings Prompt to use a different
app store with the [Apptentive.setRatingProvider(IRatingProvider ratingProvider)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setRatingProvider-com.apptentive.android.sdk.module.rating.IRatingProvider-)
method. If you would like to open an app store we don't yet support, you can implement the
[IRatingProvider](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/IRatingProvider.html)
interface.

### Supported App Stores

The Apptentive SDK comes with support for these app stores.

* [Google Play](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/impl/GooglePlayRatingProvider.html)
* [Amazon Appstore](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/module/rating/impl/AmazonAppstoreRatingProvider.html)

### Settings Rating Provider Arguments

If you build a custom Rating Provider, you may require additional data to be passed in. You can pass properties in in
this way.

[Apptentive.putRatingProviderArg(String, key, String value)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#putRatingProviderArg-java.lang.String-java.lang.String-)

## Push Notifications

You can leverage your push notification provider to notify customers when you respond to their feedback. With push
notifications, your customer will see a notification, even if they haven't recently opened your app.

### Supported Push Providers

* Urban Airship
* Amason Web Services SNS
* Parse

[Setting up Push Notifications](http://www.apptentive.com/docs/android/integration/#push-notifications)

![Push In Notification Area](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/push_in_notification_area.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Push In Notification Drawer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/push_in_notification_drawer.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/10px.png)
![Push Notification Opened](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/push_notification_opened.png)

## Custom Data

You can send custom data associated with the **Device** or **Person**, that will be surfaced for you on our website. Data must be
key/value string pairs. You can use this data simply to fill in information about the customer, but you can also use it
in **[Interaction](#interactions)** logic to to determine when they can be displayed.

* [Apptentive.addCustomDeviceData(Context context, String key, String value)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#addCustomDeviceData-android.content.Context-java.lang.String-java.lang.String-)
* [Apptentive.removeCustomDeviceData(Context context, String key)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#removeCustomDeviceData-android.content.Context-java.lang.String-)
* [Apptentive.setCustomDeviceData(Context context, Map<String, String> customDeviceData)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setCustomDeviceData-android.content.Context-java.util.Map-)
* [Apptentive.addCustomPersonData(Context context, String key, String value)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#addCustomPersonData-android.content.Context-java.lang.String-java.lang.String-)
* [Apptentive.removeCustomPersonData(Context context, String key)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#removeCustomPersonData-android.content.Context-java.lang.String-)
* [Apptentive.setCustomPersonData(Context context, Map<String, String> customDeviceData)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setCustomPersonData-android.content.Context-java.util.Map-)

## Specifying a Customer's Contact Information 

If you would like to see your customer's email and name, you can pass them to Apptentive. Passing us this information will let you address the customer by name,and reply to their feedback via email.

[Apptentive.setInitialUserEmail(Context context, String email)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setInitialUserEmail-android.content.Context-java.lang.String-)

[Apptentive.setInitialUserName(Context context, String name)](http://www.apptentive.com/docs/android/api/com/apptentive/android/sdk/Apptentive.html#setInitialUserName-android.content.Context-java.lang.String-)


## Building from the command line and with CI

### Building with ant

The Apptentive SDK can be built using the `ant` based build tools bundled with the Android SDK. In order to prepare Apptentive for automated builds with ant, you will need to prepare the project for builds using the `android` tool packaged with the Android SDK. Open a shell and run `android update project -p ./ -t android-18` in the apptentive/apptentive-android-sdk directory. The target, `android-18` in the example, can be any version of android greater than or equal to 3.1 (`android-12`).

Once you have initialized the build files, Apptentive will build automatically as part of your ant based build system. In the event that you update your Android SDK or Android Build Tools, you may need to re-run the `update project` command to generate new build files.

## ProGuard Configuration

Since Apptentive is an open source SDK, it is not necessary to obfuscate Apptentive code. If you are using ProGuard, Apptentive classes and methods will be obfuscated unless you add the following to your project's `proguard-project.txt`:

```java
-keepattributes SourceFile,LineNumberTable
-keep class com.apptentive.android.sdk.** { *; }
```

## Known Issues

* If you are using the [OkHttp](http://square.github.io/okhttp/) library, please make sure you are using OkHttp version 1.5.2 or greater, as previous versions can cause your app to crash when another library attempts to make an SSL connection.
