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
    How can we test it in our development environment? We tried with days = 0 plus events = 1 but it isn't working.
  </dt>
  <dd>
    Making any of the ratings prompt values 0 makes them ignored (there's a note to this effect in the settings page). It sounds like you haven't passed along a significant event. This is a variable you can program against so it's unique to your app. As an example, some of our customers will increment the events account every time an app customer passes a level. Since you've 0'd out the days and you're not passing along an event value as of yet, this should explain why you're not seeing it. The easiest way to test this would be to use the "Launches" variable and make it a low number. When you're in development mode in Xcode on iOS the normal 24 hour refresh of app settings are ignored and refreshed with each launch. 
  </dd>
</dl>


## Ratings

<dl>
  <dt>
    Do you have best practices on setting up your ratings prompt?  
  </dt>
  <dd>
    Every app is different so it is important to experiment with when and how often you use the ratings prompt.
  </dd>
</dl>

<dl>
  <dt>
    Can I edit the "Do you love...?" prompt that users see?
  </dt>
  <dd>
    ?
  </dd>
</dl>

<dl>
  <dt>
    How can I change the language of the ratings prompt?
  </dt>
  <dd>
    To change the language of the "rating prompt" you need to change it directly in the code. Currently it is not possible to change it through the dashboard. Here is an example of how one of our customers changed the "rating prompt" to spanish: https://github.com/apptentive/apptentive-ios/blob/master/ApptentiveConnect/resources/localization/es.lproj/Localizable.strings
  </dd>
</dl>

<dl>
  <dt>
    As far as suggestions go, here are a few:
  </dt>
  <dd>
    Make sure that you've also created a "Feedback" or "Contact Us" navigation component in your app in a logical place for customers to find it. This will assist in helping you get more of the direct feedback and ensuring that your customers know how to speak to you instead of going to the app store - We find that thinking about significant events and passing along counts for those variables helps our customers get more granular about their prompts and are able to tie them to moments of success more effectively - When launching, it's a good idea to start conservatively and then change the settings over time as you learn about customer behavior. For example, a pretty common set of generic triggers is 10 days on device and 5 app launches. After a couple of weeks you should have some data and be able to change the settings up and see how your love ratio (the % of people who see the prompt and click "Yes" to the question) shapes up.
  </dd>
</dl>


## Feedback

<dl>
  <dt>
    How do I integrate Apptentive with my 3rd party CRM?
  </dt>
  <dd>
    Contact us. You must be on a corporate plan or above for this feature.
  </dd>
</dl>

<dl>
  <dt>
    Can I reply to feedback straight from my e-mail?
  </dt>
  <dd>
    Yes, if the e-mail address is included in the message you can reply directly from your e-mail.
  </dd>
</dl>


## Surveys

<dl>
  <dt>
    Only certain plans offer ‘Multiple Surveys’. How is that different than having Surveys?
  </dt>
  <dd>
    ?
  </dd>
</dl>

<dl>
  <dt>
    I was under the impression that if there was an active survey, it would be presented in place of the normal “send us an email” flow.  Is that not the case?
  </dt>
  <dd>
    If it isn’t what rules are used to send people to the survey? Also, concerning the rule “Multiple Responses Per Device” – is that per device type or per unique device (user)? Can surveys be edited once they are published? Surveys require a bit of work in your app in order to ensure that they show. Your engineers will have to make a specific call for the survey they'd like to show in your app, at the point in time you'd like to show it. So, as far as "rules" go, it's really up to you. We often see customers calling a survey after someone has completed a level or hit a certain point in usage.  As far as "Multiple Responses Per Device" - this is per unique device. The idea here is that some surveys are ongoing sentiment analyses and others are one-time research exercises. Surveys can definitely be edited once published. You can stop the survey or modify it at any point in time through the dashboard. Once you've created a survey, those options will be available to you, along with the reports of the results.
  </dd>
</dl>

<dl>
  <dt>
    Does Apptentive support multiple surveys”?
  </dt>
  <dd>
    We do support multiple surveys for our paid customers (Pro and above), that might be part of the confusion here. Using "tags" we support calling different surveys and we can actually allow you to add custom data to each of your communications in order to get more granular.
  </dd>
</dl>

<dl>
  <dt>
    How do the live surveys work?
  </dt>
  <dd>
    You can take them through the high level that they add our SDK to their app, pick the location in their code that they might want a survey to appear, add the API call at that point, and then use our server to define and deliver the survey to their clients.
  </dd>
</dl>


## Apptentive Support

<dl>
  <dt>
    Why don’t I see any data in the Love Ratio?
  </dt>
  <dd>
    The Love Ratio is based on responses to the "Do you love..." ratings prompt and will be empty until you've had users respond to that dialog. If you've gotten feedback or had users go through these dialogs and still aren't seeing data, please let me know and I'll take a look.
  </dd>
</dl>

<dl>
  <dt>
    What is the Love Ratio?
  </dt>
  <dd>
    The Love Ratio is a calculation based upon if you're using our Ratings Prompts. The ratio will display the % of the time that your customers are clicking "Yes" to the question, "Do you love [app name]?" and does so on a daily basis, so you can see the changes in the ratio over time, depending on your settings. The feedback volume keeps track of how much feedback you're receiving from your customers over time. It's just based upon the number of people who give feedback through any place you've implemented our feedback capabilities, including feedback received as a result of showing the ratings prompt.
  </dd>
</dl>

<dl>
  <dt>
    What is Ratings Done Right?
  </dt>
  <dd>
    Ratings Done Right is what we call our intelligent ratings prompts that lead customers to give you feedback if they aren't thrilled with your app, or rate you in the app store if they are loving the experience. When and how often your customers are prompted with the ratings dialog is controlled by you.
  </dd>
</dl>

<dl>
  <dt>
    How can I build my own feedback/question form and put it into my app (iOS/Android)?
  </dt>
  <dd>
    You don't have to build a form - you just make a call to our feedback form and it'll display inside your app. We've done all the hard work around offline support, designing the form, collecting device information etc - you just need a button that says "Give Feedback" or "Contact Us" or an icon for help in your app that calls us.
  </dd>
</dl>

<dl>
  <dt>
    What does “Monthly Active Users” specifically mean?
  </dt>
  <dd>
    Monthly Active Users is for your app - however many people you have using your app(s) on a monthly basis. It means the number of unique devices identified using the app over the period of a calendar month.
  </dd>
</dl>

<dl>
  <dt>
    Can I use the “Starter” (free) plan for multiple apps if the together they all have less than 5,000 monthly active users?
  </dt>
  <dd>
    With the Starter plan, you can use us for up to 2 apps, with up to 2 collaborators, until your collective audience of monthly active users exceeds 5,000.
  </dd>
</dl>

<dl>
  <dt>
    What is the best word to effectively get people to send feedback?
  </dt>
  <dd>
    "Give Feedback", "Send Feedback" and "Contact Us" are all pretty standard and use action-oriented language that helps increase consumer activities. If you are space limited, "Feedback" can work as well.
  </dd>
</dl>

<dl>
  <dt>
    How often does my dashboard update with data?
  </dt>
  <dd>
    Daily, weekly? Am I able to update this manually? The data in the dashboard updates in real time.
  </dd>
</dl>


## Best Practices

<dl>
  <dt>
    How do I get people that love the app to proceed to the next step of rating/reviewing me?
  </dt>
  <dd>
    We recommend experimenting with some of the settings around the prompts. Sometimes prompts are being used too early for the customer, or maybe too late - Changing the timing of the prompts can result in higher conversion - it is dependent on where they are in adoption of the app as well as usage in order to get going. We find that having prompts after significant events -- after making a purchase, or after completing an achievement -- can result with a higher % people going through the entire ratings process.
  </dd>
</dl>

<dl>
  <dt>
    Can we take a screen shot of the last screen the user viewed just before giving feedback?
  </dt>
  <dd>
    How do others best use the attached screenshot feature? If the feedback button is implemented on multiple screens of the app, you can set the screenshot feature to capture the screen where the consumer hits the button. If it's only on one or 2 screens, attaching the "last screen" gets much tougher and would require you to pass along some historical data and snap screenshots along the way. We haven't seen anyone implement it this way as of yet, but if this is something you are interested in we could probably schedule a call to chat about it a bit more.
  </dd>
</dl>

<dl>
  <dt>
    Best practice for Apptentive.
  </dt>
  <dd>
    Other best practices: you'll want to start the ratings prompt settings off conservatively, watch the data for at least a week and then make modifications from there. Also, if you have registration and have email addresses, you can pre-populate the email address from your database, making it easier for the consumer. You can also pass along custom data, if you have information that is helpful to you, like User ID.
  </dd>
</dl>


## Upgrade Your Account

<dl>
  <dt>
    If I find myself exceeding my current plans limits (for more information on plans, check out http://apptentive.com/plans), how do I upgrade my account?
  </dt>
  <dd>
    Log into your Apptentive account and click “Your Plan & Billing” in the top right. Follow the instructions to add your credit card (if not added already). Once added, click on "Change Plan" and select the plan that is right for you.
  </dd>
</dl>

<dl>
  <dt>
    If I exceed my current plan
  </dt>
  <dd>
    ?
  </dd>
</dl>
