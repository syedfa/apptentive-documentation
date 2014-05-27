# Surveys

## Introduction

Apptentive Surveys enable you to collect structured feedback, in-app, from your customers. Surveys can be targeted to specific groups of customers, and using the latest versions of our SDK, can be shown as part of the Ratings Prompt flow instead of the Feedback Form. Surveys are rendered natively on a device to ensure a robust, performant experience for your customers whether they're offline or online.

**NOTE: These instructions were written for version 1.5.0 or above of the Apptentive iOS and Android SDKs, which were released on May 27, 2014.**  If you're not using version 1.5.0 or above, we highly recommend you upgrade so that you'll be able to take advantage of all of the latest functionality. Please [contact us](http://www.apptentive.com/contact) for more details or for assistance upgrading.

## Instrumenting for Surveys

Displaying Surveys in your app only requires that you've completed a standard Apptentive integration, and have added the appropriate calls to `Apptentive.engage` for the **Events** where you at some point might like to show a Survey.

For more details on integrating Apptentive, please see the [iOS Integration Documentation](http://www.apptentive.com/docs/ios/) and the [Android Integration Documentation](http://www.apptentive.com/docs/android/).

## Creating a Survey

Surveys are created from within the Interactions section of the [Apptentive dashboard](https://be.apptentive.com/). When creating a new Survey, you'll first be asked to provide a title and description, which will be shown to your customers.

### Adding Questions

After you set your title and description, you can then add your questions to the Survey. There are three questions types you can ask:

* FreeForm questions provide the customer with an area for an open-ended response. You can elect for this area to be either a single line or multiple lines to encourage longer answers.

* Single Select questions provide the customer with multiple choices, only one of which can be selected. You can elect to randomize the choice order to reduce presentation biases.

* Multiple Select questions provide the customer with multiple choices, and allows them to select between a minimum and maximum number based on your settings.

As you're adding questions, you can decide whether each is required or optional. If a question is required, the customer will not be able to submit the Survey without answering that question.

### Publishing

When the customer completes your Survey, you can optionally display a "Thank You Message" of your choosing. If you do not display this message, the Survey screen will be dismissed without further UI when the Survey is completed.

Apptentive provides robust targeting and lifecycle management options for Surveys to ensure that your Surveys are shown to the right people at the right time.

Under the Target Audience section of the Publishing page, you can use the data automatically collected by Apptentive, such as Device model, OS Version, etc., as well as Custom Data you've provided to target the Survey to a specific group of customers. More information about using Custom Data is available in the [iOS Integration Documentation](http://www.apptentive.com/docs/ios/) and the [Android Integration Documentation](http://www.apptentive.com/docs/android/).

Starting with the 1.5.0 versions of the Apptentive SDKs, Surveys are displayed at a specific event that's been instrumented via the `Apptentive.engage` method. Older versions of the Apptentive SDK use a targeting mechanism based on tags.

If you do not want your Survey displayed for customers using the Apptentive SDK before version 1.5.0, you may select the "Do not display this Survey to older clients" option on the Survey publishing page. Otherwise, the Survey will be available for display on pre-1.5.0 SDK versions, and will use the tags-- when present-- for targeting.

As part of publishing, you can also optionally set a start time and an end time for your Survey, and/or end the Survey once a certain number of responses has been received. You can further limit the frequency that an individual person will see the Survey, and/or whether to allow the same person to submit multiple responses to the Survey.

If you're on a Starter plan, you'll be able to have 1 concurrent Survey published at any given time. Our Learn plan supports up to 2 concurrent Surveys, and our Grow and Enterprise plans permit unlimited concurrent Surveys. For more information, please see our [plans](http://www.apptentive.com/plans/), or [contact us](http://www.apptentive.com/contact) for more details.

Once you publish the Survey, it will begin being distributed to your customers. Surveys are cached on customer devices for several hours, so customers that have recently fetched Surveys may not see the updated Survey until the cache period expires. During testing, you can uninstall and reinstall the app to force the cache to flush.

## Modifying Surveys

To help ensure the statistical integrity of your results, you cannot modify a Survey once published. Instead, if you wish to make changes, the existing Survey will be cloned, and the new Survey will replace the existing one.

## Using a Survey with the Ratings Prompt

Starting with version 1.5.0 of the Apptentive SDKs, you can use a Survey to collect structured feedback from your customers following the initial "Do you love..." Ratings prompt. This replaces the Feedback Form that is shown by default.

To use a Survey with the Ratings Prompt, you should first create the Survey as described above. Note that when using a Survey with the Ratings Prompt, any lifecycle or targeting options you specify will not be applied.

Once the Survey has been published, you can include it in the Ratings Prompt. These settings are also available under the Interactions section of the [Apptentive dashboard](https://be.apptentive.com/). To use the Survey, under the "The Prompt" section, change the target of the "No" button on the initial prompt to "taken to a Survey...". You can then select the Survey you just created.

If you have customers using a version of the Apptentive SDK prior to 1.5.0, they will continue to see the Feedback Form instead of the Survey.