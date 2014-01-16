# Hidden Messages

## Introduction

Hidden Messages are designed to easily enable you to add logs, crash reports, images, other file types, and/or extended text messages to a conversation in Message Center.  Hidden Messages are only visible to you and other app members via the Apptentive Website-- these messages are not displayed to your customers and do not appear within Message Center in your app.

## Hidden Message Behaviors

Hidden Messages are treated in the same way as other messages in Message Center, with the exception of a few important details:

1. Hidden Messages will are not provided to the client and are thus not displayed within Message Center in the app.
1. When a new Hidden Message is received by the server, an email notification will be sent to those app members who elect to receive email notifications of new messages.  Unlike other email notifications on new messages, replies to these emails will be discarded and will not be forwarded on to the customer.  (These emails are clearly denoted as relfecting a hidden message.)
1. Hidden Messages do _not_ trigger any integrations configured for the app.  Consequently, Hidden Messages will _not_ be pushed to third party systems such as Zendesk, UserVoice, or Desk.com, nor will Hidden Messages be included in the unread message notifications (Email, Urban Airship).
1. Hidden Messages are displayed slightly differently on the Apptentive Website to make them easy to identify.


## Requirements

To use Hidden Messages, you must be using iOS SDK version 1.2.6 or greater, or Android SDK version X or greater.

## 