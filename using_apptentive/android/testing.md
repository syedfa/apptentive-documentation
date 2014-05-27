# Testing Your Apptentive Integration

This document will help you verify that **Events** and **Interactions** have been properly configured within your app.

### Dedicated Test API Token

We recommend using a dedicated test API token when exploring Apptentive features.

Create a new app on your Apptentive dashboard, then find its API token in **_Settings -> API & Development -> Your API Token_**. Set the test API token in your `AndroidManifest.xml`.  

```xml
<meta-data android:name="apptentive_api_key" android:value="YOUR_API_KEY_GOES_HERE"/>
```

Using a test API token will allow you to modify Apptentive settings without fear of annoying the users of your live app.

### Testing the Rating Prompt

To verify that the [Ratings Prompt](http://www.apptentive.com/docs/android/features/#ratings-prompt) has been integrated correctly into your app, you will first need to set up at least one [Event](http://www.apptentive.com/docs/android/integration/#adding-events).

Once you have done that, go into the Ratings Prompt configuration under **_Interactions -> Ratings Prompt_**. Click the **_Who & When_** tab and in the section titled **Who will this be shown to?**, uncheck all but the first checkbox. Then, make sure this checkbox is set to **Less Than 1**. By doing this, you will guarantee that the Ratings Prompt will be shown.

Next, you will need to choose which **Event** that the Ratings Prompt should be targeted to. In the ** When will this be shown?** section, choose the **Event** that you just set up from the dropdown list. If you don't see it in the list, first verify that you have triggered this **Event** at least once, so that the server is aware of it.

Finally, launch your app and verify that the Ratings Prompt appears when you trigger your chosen **Event**

Notes:
* If you change the Ratings Prompt content or logic, you will need to clear the SDK's cache by clearing your app's data or uninstalling and reinstalling it, before you will be able to see the changes in your app.

### Testing Surveys

Just like with **Ratings**, [Surveys](http://www.apptentive.com/docs/android/features/#surveys) require you to create at least one **Event**.

Once you have created an **Event**, open [apptentive.com](https://be.apptentive.com) and go to **_Interactions -> Surveys_**. There, click **New Survey**, and fill out your test **Survey** content. On the final page, you will be able to choose the targeting information. To make sure the **Survey** shows up, only change the **Select Event** dropdown. In this dropdown, you should select the **Event** that you just created.

Once you have created the **Survey**, make sure that you uninstall and reinstall the app so that it is forced to download the latest **Interactions**, and trigger the **Event** that you chose for your **Survey**. You should see the **Survey** display.
