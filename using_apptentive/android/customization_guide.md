# Interface Customization

Our Android SDK is 100% open source, and as such, you can modify the UI and underlying code at any time. However, the Apptentive Android SDK is built in such a way that simple UI style changes are very easy to make without having to modify our code.

If you have a need for customizing the UI beyond what is covered below, [we'd love to hear from you!](http://apptentive.com/contact/)

# Customizing the User Interface
Our Apptentive Android SDK is packaged as an Android Library Project. That means that it has its own source code and resources. Resources include drawables, layouts, styles, dimensions, and so on. The nice thing about Android Library Projects is that the host application can override any styles Library Projects define. We designed our UI to be compatible with a wide range of app styles, but if you feel like it could look better in your app, here are a few examples of how to modify it.

## Modify Interaction Colors
If your app has a significantly different color scheme than our SDK, you may choose to modify our colors by overriding them.

* Create a new file _res/values/apptentive_colors.xml_, and copy the relevant colors from _apptentive's /res/values/colors/xml_
* Change the values to suite your design.
* Screenshots

## Hiding Apptentive Branding

The option to hide Apptentive branding is available to our Enterprise customers. For our Enterprise customers, branding can be hidden remotely from your dashboard's Global App Settings. If the "Apptentive Branding" section is not visible, please contact support@apptentive.com to learn how to make this feature available for your account.

* hide branding manifest file setting.

"Hide Branding" hides the Apptentive logos at the top of the Message Center and on the Contact Settings screen.

The Apptentive logo will still be displayed on the About Apptentive screen, which can be reached by tapping the white bar at the bottom of the Contact Settings screen:

If you have customizations you'd like in our project, the best way to get them is to [let us know](http://apptentive.com/contact/). We're happy to discuss them!

