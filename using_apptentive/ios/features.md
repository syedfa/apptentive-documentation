##Apptentive Features

We recommend adding several features to get the most out of Apptentive. These include:

 - Setting your API Key and App Store ID
 - Configuring the Enjoyment Dialog ("Do you Love *app_name*?")
 - Adding a Feedback button to your settings menu
 - Notifying the user that new unread messages have arrived
 - Integrating your Push Notification service
 
This Feature guide for the Apptentive iOS SDK will walk you through adding these common and useful features to your app.

###Set your Apptentive API Key

After including Apptentive in your Xcode project, the first step of integration is to register your Apptentive API Key and App Store ID. This is typically done in your app delegate's `application:didFinishLaunchingWithOptions:` method:

``` objective-c
#import "ATConnect.h"

//...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Apptentive API Key
	[ATConnect sharedConnection].apiKey = @"YOUR_APPTENTIVE_API_KEY";
	
	// App Store ID
	[ATConnect sharedConnection].appID = @"YOUR_APP_ID_FROM_THE_APP_STORE";
	
	/* ... */
}
```

### Do you Love Apptentive?

Apptentive's Ratings Prompt displays a "Do you love *app_name*?" dialog to the user. Your app's *Love Ratio* is determined by people's answer to this question.

The dialog is shown by engaging a certain event in your app that you have targeted, online, to run the Ratings Prompt. If the current rating conditions are satisfied, the enjoyment dialog will be shown.

	[[ATConnect sharedConnection] engage:@"test_rating_prompt" fromViewController:viewController];

These Ratings Prompt conditions can be changed at any time via the Apptentive website. This feature enables you to remotely change Apptentive Ratings Prompt settings without issuing an iOS app update.

### App Store Ratings Prompt

Asking people who love your app to rate it in the App Store is a great way to increase your App Store star rating.

The Ratings Prompt is triggered by engaging an event in your app, which you then target via your Apptentive dashboard settings:  

	[[ATConnect sharedConnection] engage:@"test_rating_prompt" fromViewController:viewController];

Despite being triggered, the Ratings Prompt is shown only if your set conditions are met. For example, you might decide the Ratings Prompt should be shown after 5 days of use, 10 app launches, and 3 significant events. These settings can be modified on the Apptentive website.

When presented with the "Do you love *app_name*?" dialog, the user can select "Yes" or "No". They will be presented with different behaviors based on their answer to the question.

People who select "Yes" will be asked to rate the app on the iOS app store.

Those who indicate they do not like the app will be prompted to send feedback directly to the developer via the Apptentive feedback form.

### Surveys

Apptentive surveys are used to collect information from the people using your app.

Like the Ratings Prompt, surveys are created online and targeted at events in your app. 

	[[ATConnect sharedConnection] engage:@"test_survey" fromViewController:viewController];

These surveys can be released completely remotely, between App Store updates, as long as you have engaged an event to trigger the survey. Seed your app with events now, and you will be able to display surveys at any given event in the future. 

### Feedback from Users (Apptentive Message Center)

The Apptentive Ratings Prompt will prompt some users to send you direct feedback. You can respond to this feedback from your online Apptentive dashboard.

It is important to implement a Feedback button, so that users can open up the Apptentive Message Center at any time. 

You should also alert users that a new Apptentive message has arrived.

### Feedback Button

Developers should implement a button for giving direct feedback via Apptentive's Message Center. This button is often found in the app's "Settings" menu.

This button could be titled "Give Feedback", "Need Help?", "Support", or etc. depending on your application.

Create an IBAction that calls `presentMessageCenterFromViewController:` and wire it up to a button in your app's interface using Interface Builder:

``` objective-c
- (IBAction)giveFeedback:(id)sender {
	[[ATConnect sharedConnection] presentMessageCenterFromViewController:self];
}
```

People using your app will use this button to send you direct feedback. They can also use it to return to Message Center at any time and reference their past conversations.

### Unread Messages

You should alert the user that a new message has arrived in response to their feedback.

Apptentive posts the `ATMessageCenterUnreadCountChangedNotification` notification when a new message arrives. Listen for this notification using NSNotificationCenter:

``` objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadMessageCountChanged:) name:ATMessageCenterUnreadCountChangedNotification object:nil];
```

When the notification listener fires, update your UI or otherwise alert the user that a response to their feedback has arrived.

For example, if you have a Feedback button in your settings, you could decorate it with a "1" badge when an unread message arrives.

``` objective-c
- (void)unreadMessageCountChanged:(NSNotification *)notification {
    // Unread message count is contained in the notification's userInfo dictionary.
    NSNumber *unreadMessageCount = [notification.userInfo objectForKey:@"count"];

    // Update your UI or alert the user when a new message arrives.
    NSLog(@"You have %@ unread Apptentive messages", unreadMessageCount);
}
```

The method `unreadMessageCount` can also be used to get the number of unread messages at any time.

### Push Notifications

Apptentive can integrate with your existing [Urban Airship](http://urbanairship.com/) account to offer push notifications when new Apptentive messages are available.

First, register an Urban Airship configuration with your device token. If you are using the [Urban Airship library](http://docs.urbanairship.com/build/ios.html#download-install-our-library-frameworks), the device token can be obtained in your app delegate's `didRegisterForRemoteNotificationsWithDeviceToken:` method:

``` objective-c
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Device token string
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                       ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                       ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                       ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];

   // Register the device token with Apptentive
   [[ATConnect sharedConnection] addIntegration:ATIntegrationKeyUrbanAirship withConfiguration:@{@"token": token}];
}
```

When push notifications arrive, pass them to Apptentive:  

``` objective-c
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // Pass the push Notification userInfo dictionary to Apptentive
    [[ATConnect sharedConnection] didReceiveRemoteNotification:userInfo fromViewController:viewController];
	
	// You are responsible for clearing badges and/or notifications, if desired. Apptentive does not reset them.
	application.applicationIconBadgeNumber = 0;
}
```

If the push notification was sent by Apptentive, we will then present Message Center from the `viewController` parameter.

If you are interested in using a Push Notification service other than Urban Airship, please contact us!

### Debug Logging

Apptentive logs a variety of information to the Xcode console when it is running. These logs can help you determine, for example, when an event is engaged and if an interaction will be shown for the event.

Logging can be customized using the `debuggingOptions` property of ATConnect. To use the property, include the additional `ATConnect_Debugging.h` header file in your project.

    #import "ATConnect_Debugging.h"
    ...
    / Log all HTTP requests made by Apptentive
    [ATConnect sharedConnection].debuggingOptions = ATConnectDebuggingOptionsLogAllHTTPRequests;

The various `ATConnectDebuggingOptions` members are used to specify the types of information Apptentive should log. One common use case of `debuggingOptions` is to log and examine all Apptentive HTTP requests.
