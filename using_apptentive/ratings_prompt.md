# Ratings Prompt

## Introduction

Apptentive's Intelligent Ratings Prompt enables you to engage with your customers, solicit constructive feedback, and drive great ratings and reviews in the app store.

The Intelligent Ratings Prompt requires that you or your developer has added the Apptentive SDK to your application. Please make sure to review the [iOS](/docs/ios) or [Android](/docs/android) Integration Documentation as appropriate.

This document provides an overview of Apptentive Events & Interactions, which are the building blocks of the Intelligent Ratings Prompt, as well further details on configuring the Ratings Flow from within the Apptentive Dashboard.

## Events & Interactions

**Interactions** allow you to proactively start conversations with your customers. Unlike Message Center and feedback in general, you can use Interactions to start communicating with a customer based on how they are using the app. An Interaction is a view that is shown to the customer when certain conditions are met.

The core pieces of information used to determine when and where Interactions are displayed are called **Events**. An Event represents a place in your code where your customer performed an action. Apptentive keeps track of all Events, and the record of Events enables you to perform very fine grained targeting of Interactions to customers. You can configure Interactions to run when a certain combination of Events has been triggered.

The Apptentive `engage` method makes all of this happen.  When you call `engage("event_name")`, not only are Events created, but Interactions are run if the necessary conditions are met. This simple, but powerful method, will let you precisely target who to talk to at the right time. You are recommended to find a few places in your code that you would like to track, and a few places where it would be appropriate to show an Interaction. Come up with an Event name that describes each place, and make a call to `engage()`. Later on, you can configure Interactions based on those Events.

### Event ###

An **Event** is a record of your customer performing an action. An Event is always generated when you call the Apptentive `engage` method. Apptentive stores a record of all events, and events can be used later to determine when to show interactions to your customer.

### Interaction ###

An **Interaction** is an action that is performed on the client. Interactions are defined on the server, and downloaded to the client. Interactions generally result in a view being shown to your customer. Like Events, Interactions are launched by calling the Apptentive `engage` method, but are invoked only when the necessary conditions are met.


## Configuration

The Apptentive Ratings Prompt is configured from within the Apptentive Dashboard under the 'Interactions' section.

When configuring the Ratings Prompt, you'll first have an opportunity to view each of the screen associated with the Ratings Flow. For each screen, you may either leave the default text as-is, or customize it so that it is consistent with the voice and spirit of your app.

**Note**:  Localization is currently provided for [12 languages](http://www.apptentive.com/features/availability/). When you customize the text of the Ratings Prompt, only the English version will be updated on the device.  Other languages will continue to use the defaults included as part of the in-app localization bundle.

In addition to configuring the text of the Ratings Prompts, you may also indicate whether you wish to request the customer's email address, and, if so, whether an email address should be required.

The second page of the Ratings Prompt configuration enables you to indicate to *Who* and *When* the prompt should be displayed. You can trigger this based on the time since the customer installed the app, the number of launches since they've installed the app, and/or the number of occurrences of a specific Event. Once these criteria are set, you should then set the Event that the ratings prompt will be invoked at under the **When** section.

At your option, the Ratings Prompt may be shown at most once to a given customer, or you can show it multiple times and limit by version of your app and/or frequency of display.

At any time, you may wish to pause the display of the Ratings Prompt. You can do so from the "Launch" section of the Ratings Prompt settings.

### Legacy Clients ###

If you have customers that are using a release of your App with an older version of the Apptentive SDK, you can configured the Ratings Prompt settings for them under the "Legacy Clients" section of the Ratings Prompt configuration. These settings are the same as those that had previously appeared under the "App Settings" menu.


## Best Practices

* The default Ratings Prompt language, and in particular the "Do you love..." question, has been carefully tested to help ensure that your strongest fans provide positive feedback in the App Store and your toughest critics come directly to you with their constructive criticism. We recommend starting with these defaults.  It's easy to change them later!

* Despite the popularity of doing so, asking for Ratings at app launch is frequently not the best time to do so. We recommend identifying a "point of positive experience" within your app and creating an Event at that location of display of the Ratings Prompt. This could be between game levels, after sharing a photo, upon adding an item to a To Do list, etc. The more Events that you add to you app, the greater the flexibility you'll have to experiment with various locations.

* We recommend selecting Ratings Prompt criteria that are conservative and are most likely to include customers that have had a chance to engage with your app and form an opinion about it. If you're just starting out, the default values are likely a good choice, and you can easily experiment with them later without making any changes to your app!