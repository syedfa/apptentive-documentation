# Interface Customization

Our Android SDK is 100% open source, and as such, you can modify the UI and underlying code at any time. However, the Apptentive Android SDK is built in such a way that simple UI style changes are very easy to make without having to modify our code.

If you have a need for customizing the UI beyond what is covered below, [we'd love to hear from you!](http://apptentive.com/contact/)

# Customizing the User Interface
Our Apptentive Android SDK is packaged as an Android Library Project. That means that it has its own source code and resources. Resources include drawables, layouts, styles, dimensions, and so on. The nice thing about Android Library Projects is that the host application can override any styles Library Projects define. We designed our UI to be compatible with a wide range of app styles, but if you feel like it could look better in your app, here are a few examples of how to modify it.

#### Original UI Examples
![Original Enjoyment Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/customization_enjoyment_before.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/10px.png)
![Original Feedback Dialog](https://raw.githubusercontent.com/apptentive/apptentive-documentation/master/using_apptentive/android/screenshots/customization_feedback_before.png)

## Modify Interaction Colors
If your app has a significantly different color scheme than our SDK, you may choose to modify our colors by overriding them.

1. In your app, create a new file __*res/values/apptentive_colors.xml*__, and copy the relevant colors from Apptentive's [res/values/colors.xml](https://github.com/apptentive/apptentive-android/blob/master/apptentive/res/values/colors.xml). The name you choose or this file isn't important, but the names of the keys are.
2. Change the values to suite your design. Make sure you use the original Apptentive name for your keys.

  ```xml
  <color name="apptentive_dialog_title_text">#22AA22</color>
  <color name="apptentive_dialog_button_negative_text">#FF0000</color>
  <color name="apptentive_dialog_button_positive_text">#0000FF</color>
  ```

#### Modified Color Examples
![Enjoyment Dialog With Modified Colors](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/customization_enjoyment_colors.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/10px.png)
![Feedback Dialog With Modified Colors](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/customization_feedback_colors.png)

## Modify Interaction Dimensions
You can also modify Interaction dimensions, such as margin, padding, and font size. Apptentive's dimensions are located in [res/values/dimensions.xml](https://github.com/apptentive/apptentive-android/blob/master/apptentive/res/values/dimensions.xml). Note that since the Apptentive Android SDK supports multiple screen sizes and layouts, there are multiple `values` folders, each with a configuration qualifier, and to provide a consistent look, you will need to override the same dimension for each of these configurations.

1. In your app, create a new file __*res/values/apptentive_dimensions.xml*__, and copy the relevant colorsdimensions from Apptentive's [res/values/dimensions.xml](https://github.com/apptentive/apptentive-android/blob/master/apptentive/res/values/dimensions.xml). Make sure you also do this for the other supported configurations.

  | Supported Resource Configuration |
  | -------------------------------- |
  | `values-sw360dp-land` |
  | `values-sw360dp-port` |
  | `values-sw600dp-land` |
  | `values-sw600dp-port` |
  | `values`  (smaller screens) |

2. Change the values to suite your design. Make sure you use the original Apptentive name for your properties.

  ```xml
  <dimen name="apptentive_activity_side_padding">40dp</dimen>
  ```

#### Modified Dimension Examples
![Enjoyment Dialog With Modified Colors and Dimensions](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/customization_enjoyment_dimensions.png)
![spacer](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/10px.png)
![Feedback Dialog With Modified Colors and Dimensions](https://raw.githubusercontent.com/apptentive/apptentive-documentation/android/using_apptentive/android/screenshots/customization_feedback_dimensions.png)

## Hiding Apptentive Branding

The option to hide Apptentive branding is available to our [Enterprise](http://www.apptentive.com/plans/) customers. For our Enterprise customers, branding can be hidden remotely from your dashboard's Global App Settings. If the "Apptentive Branding" section is not visible, please contact support@apptentive.com to learn how to make this feature available for your account.

Because the Apptentive Android SDK needs to connect to the server before this setting can take affect, you may also want to supply this `<meta-data>` element inside your manifest's `<application>` element. This will prevent Apptentive branding from being displayed until the client asks the server what to do.
```xml
<meta-data android:name="apptentive_initially_hide_branding" android:value="true"/>
```


"Hide Branding" hides the Apptentive logos at the top of the _Message Center_ and on the _About Apptentive_ screen.

If you have customizations you'd like in our project, the best way to get them is to [let us know](http://apptentive.com/contact/). We're happy to discuss them!

