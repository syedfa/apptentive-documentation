# FAQ


## Signing Up

<dl>
  <dt>
    Do I have to enter my credit card if I’m signing up for the Starter plan?
  </dt>
  <dd>
    You do not have to enter your credit card, though we highly encourage our customers to enter their Credit Card to save them time later on when they sail past 10k MAUs or need further support.
  </dd>
</dl>

<dl>
  <dt>
    What happens if I choose the wrong plan or exceed my current plan too quickly?
  </dt>
  <dd>
    ?
  </dd>
</dl>

<dl>
  <dt>
    What are collaborators?
  </dt>
  <dd>
    Collaborators are people who can have access to managing the account. There are able to view data, manage and reply to feedback, manage the rating prompts, and deploy surveys. (????)
  </dd>
</dl>

<dl>
  <dt>What should I set for "App Store ID" when adding a new app on?</dt>
  <dd>
    <ul>
      <li>For iOS, use the Apple App ID, which is the number portion after "id": <code>https://itunes.apple.com/us/app/angry-birds/id<strong>343200656</strong></code><br/></li>
      <li>For Android, use the package name, which is the java pacakge string after "id=": <code>https://play.google.com/store/apps/details?id=<strong>com.rovio.angrybirds</strong></code></li>
    </ul>
  </dd>
</dl>


## Setting Up Your Account

<dl>
  <dt>
    What is the ‘Demo’ Dashboard?
  </dt>
  <dd>
    ?
  </dd>
</dl>

<dl>
  <dt>
    How do I claim my app?
  </dt>
  <dd>
    ?
  </dd>
</dl>

<dl>
  <dt>
    How do I get my SDK?
  </dt>
  <dd>
    ?
  </dd>
</dl>

<dl>
  <dt>
    How do I add more collaborators?
  </dt>
  <dd>
    Click on the settings tab on the left side of the dashboard and click "add members".
  </dd>
</dl>

<dl>
  <dt>
    Where is my API token?
  </dt>
  <dd>
    In order to get the API key you need to be an "admin" on the account. As an "admin" your API key can be found by clicking on Settings and looking at the top of the page.
  </dd>
</dl>

<dl>
  <dt>
    I've claimed my app, but where is the SDK?
  </dt>
  <dd>
    Now that you've claimed your app, once you have it selected in the Dashboard (selection is available in the upper lefthand corner) you can access the specific SDK installation and integration instructions under “Settings”. Alternatively, since our SDK is open source and available on Github, you can look at our repository and play with the FeedbackDemo app in Xcode: https://github.com/apptentive/apptentive-ios ADD ANDROID
  </dd>
</dl>

<dl>
  <dt>
    Do we need to set our App ID within our app to get the ratings redirect to work?
  </dt>
  <dd>
    Yes, the Appstore ID is necessary to direct to the right app in the app store. Are you having trouble configuring this or is something not working when you’re testing it?
  </dd>
</dl>

<dl>
  <dt>
    I don’t get this, stuck in Sample & Instructions, also where is the SDK?
  </dt>
  <dd>
    Can you tell us a bit more about what happened when you tried to create an app? In general, once you create an app (either manually or by finding it via search) you can select that app in the upper lefthand corner and view the integration instructions under "Settings". If you can tell us a bit more about your experience we can help you out. Thanks again for reaching out, I hope we can help solve this problem for you.
  </dd>
</dl>


## Installation

<dl>
  <dt>
    How can I connect my application from AppStore/Google Play with your data system and monitor feedback from users?
  </dt>
  <dd>
    The connection with your app in the app store is generally done automatically on iOS if your app is live and might be automatic on Google Play (the data there is tougher to get so you might have to add your app manually). The purpose of the automatic connection is to assist in the ratings process - connecting to the right app store page when we identify a customer who loves your app and asking them to visit. We don't actively monitor feedback in the app store today - we find that most of our customers get the bulk of their feedback within the app after using us and the app store ratings and reviews become a place where most of your customers are there saying great things about you, rather than using it to submit feedback.
  </dd>
</dl>


## Build Issue

<dl>
  <dt>
    Your intro docs indicate that the linker flags -ObjC -all_load are required, but this causes a conflict with another library we're using in our app
  </dt>
  <dd>
    If your app won't build with -ObjC -all_load already, then your app may already be subtly broken [0]. My first recommendation is to get your symbol conflicts resolved with the other static library, as they are likely going to cause or are already causing subtle bugs. If you want, send us the build errors and we can take a look at it and see if there's an easy fix. If you really can't do that, he can provide a version of our library that will work without the -ObjC flag. In that case, however, we would really like to know who makes the other static library in question and what the symbol conflicts are with your app so that we can follow up with the maker of the static library.  [0] Or not so subtly. In a previous customer's case, they couldn't use -ObjC -all_load because they had three different versions of AFNetworking in their app. Two from static libraries from the same vendor, and one in their project. This caused a lot of issues.
  </dd>
</dl>


## Testing

<dl>
  <dt>
    I have a build that has Apptentive integrated and I’m testing it.  However, I’m running into an issue where I can only get the prompt to appear once on the device, and then it doesn’t show up anymore.  This is good for users but makes it hard to test.  Is there any-way to reset the count (e.g., of app launches for a particular device) for testing purposes?
  </dt>
  <dd>
    <strong>Android:</strong> This is expected behavior. We only show the prompt once per app version. There are two normal ways to have the prompt show up again:
    <ol>
      <li>
        You can bump the version code (android:versionCode="1") in your app's manifest. Then, just redeploy the app. Note: This requires that you have the "Reset rating prompt counters when app version changes" checkbox checked in your app's settings on the website.
      </li>
      <li>
        You can delete the app's local settings through Android's Settings->Apps menu. This will return the app to a fresh install state.
      </li>
    </ol>
    <strong>iOS:</strong> typically you wouldd delete and reinstall the app if this is just in testing. You can also use these methods to reset the ratings flow:
  </dd>
</dl>
```
// To reset the user interactions with the ratings flow.
- (void)resetApptentiveRatings {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"ATAppRatingFlowRatedAppKey"];
        [defaults removeObjectForKey:@"ATAppRatingFlowDeclinedToRateThisVersionKey"];
        [defaults removeObjectForKey:@"ATAppRatingFlowUserDislikesThisVersionKey"];
        [defaults removeObjectForKey:@"ATAppRatingFlowLastUsedVersionKey"];
        [defaults removeObjectForKey:@"ATAppRatingFlowLastPromptDateKey"];
        [defaults synchronize];
}

// To reset just the counters for the ratings.
- (void)resetApptentiveRatingsCounters {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"ATAppRatingFlowLastUsedVersionFirstUseDateKey"];
        [defaults removeObjectForKey:@"ATAppRatingFlowUseCountKey"];
        [defaults removeObjectForKey:@"ATAppRatingFlowSignificantEventsCountKey"];
        [defaults synchronize];
}
```

<dl>
  <dt>
  </dt>
  <dd>
  </dd>
</dl>

<dl>
  <dt>
  </dt>
  <dd>
  </dd>
</dl>
<dl>
  <dt>
  </dt>
  <dd>
    <ul>
      <li></li>
      <li></li>
    </ul>
  </dd>
</dl>
