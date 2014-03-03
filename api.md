# Apptentive API (Beta)

## Introduction

The Apptentive API provides programmatic access to the various data set by the Apptentive SDK and associated with a given app. The API is organized around REST, and responses are sent using JSON. All API access is performed over HTTPS/SSL connections with a base endpoint of `https://api.apptentive.com`.

**Please note that the API is currently in beta and subject to change. While the API is in beta, you must request explicitly request your API keys from [support@apptentive.com](mailto:support@apptentive.com).**

## Authentication

Authentication is required for accessing all API endpoints. The Apptentive API uses your API key as an OAuth token, and to authentication you must provide this token in the Authorization header. For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/conversations
```

Please note that the API key used for accessing these endpoints is **different** than the key used with the Apptentive SDK within your app.

## Status & Errors

Standard HTTP Response codes are used to indicate the status of requests. In general, codes in the 2xx range indicate success, codes in the 4xx indicate an error in the data provided by the client, and codes in 5xx indicate an error on the server.

__Status Code Summary__:

* **200** The request succeeded.
* **201** The request succeeded and an object was created.
* **401** Authentication failed and the request was rejected.
* **403** Authentication succeeded by the request is not permitted and was rejected.
* **404** The requested resource could not be found.
* **422** The request included invalid input and was rejected.  The specific invalid input will be included in the response.
* **500,502,503** There was an internal server error.  You should retry the request at a later date.

## Conversations

The central object for an App is a Conversation. Each Conversation has an associated Person and Device, and provides the context for the messages and other interactions that occur for that given Person on that given device within the given App.

### Retrieving Conversations

A list of all Conversations for the App may be retrieved with a `GET` request to `https://api.apptentive.com/conversations`. For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/conversations
```

The response will contain an array of Conversations (in ascending creation order), as well as a flag indicating whether more Conversations are available:

```
{"conversations":[{"id":"5234f08cbca21f834800004d","person_id":"5234f08cbca21f834800004e","device_id":"5234f08cbca21f834800004f"},{"id":"5234f08cbca21f834800004e","person_id":"5234f08cbca21f834800004f","device_id":"5234f08cbca21f834800004b"}],"has_more":true}
```

Each Conversation will include the `id` for the Conversation, the `person_id` for the associated Person, and the `device_id` for the associated Device.

You may provide two optional arguments to page through the results:

* **skip** indicates the number of Conversations to skip in the results.
* **limit** indicates the number of Conversations to return in the results, with a maximum limit of 50.

### Retrieving a Specific Conversation

A specific Conversation for the App may be retrieved with a `GET` request to  `https://api.apptentive.com/conversations/:id`, replacing `:id` with the appropriate id (e.g. as returned in the API above). For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/conversations/5234f08cbca21f834800004d
```

The response will include the `id` for the Conversation, the `person_id` for the associated Person, and the `device_id` for the associated Device:

```
{"id":"5234f08cbca21f834800004d","person_id":"5234f08cbca21f834800004e","device_id":"5234f08cbca21f834800004f"}
```

### Retrieving Messages Associated with a Conversation

All of the Messages associated with a given conversation may be retrieved with a  `GET` request to `https://api.apptentive.com/conversations/:id/messages`, replacing `:id` with the appropriate id (e.g. as returned in the API above). For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/conversations/5234f08cbca21f834800004d/messages
```

The response will contain an array of Messages (in ascending creation order), as well as a flag indicating whether more Messages are available: 

```
{"messages":[{"id":"5224f08cbca21f8348000050","nonce":"9d427be7cd45fe676e6216a060094643a588c3f04802a11ac8ee452724c7","custom_data":{"foo":"bar","Cat":"Meow"},"type":"TextMessage","client_created_at":1378040790.54134,"client_created_at_utc_offset":34510,"created_at":1378152588.071,"sender":{"id":"5224f08cbca21f834800004e","name":"Ms. Sally Example","profile_photo":"https://secure.gravatar.com/avatar/70f7572845e98e32dc1aefa9f3cf48d3.png?d=mm&r=PG"},"body":"Initial message #0"}],"has_more":false}
```

Each message will include the following attributes:

* **id** The id of the Message.
* **nonce** A unique identifier provided by the Message creator to ensure that duplicate Messages are not accidentally created.
* **custom_data** Message-specific key/value pairs provided by the Message creator.
* **type** The type of message.  One of "AutomatedMessage", "TextMessage", or "FileMessage"
* **client_created_at** The timestamp (with fractional seconds) that the client provided when creating the Message.  Note that the time provided by the client cannot always be trusted due to incorrectly configured clocks, etc.
* **client_created_at_utc_offset** The offset, in seconds, from UTC that client_created_at represents.
* **created_at** The timestamp (with fractional seconds) that the Message was created at on the server.  In UTC.
* **sender** An object containing the id, name, and profile photo URL of the Person who sent the Message.
* **body** The body of the Message (FileMessage and AutomatedMessage only).
* **title** The title of the Message (AutomatedMessage only).
* **url** The location of the file (FileMessage only)
* **content_type** The MIME content type of the file (FileMessage only)
* **icon_url** The location of a thumbnail image representing the file (FileMessage only)

As with retrieving Conversations, the following parameters are supported to page through Messages:

* **skip** indicates the number of Messages to skip in the results.
* **limit** indicates the number of Messages to return in the results, with a maximum limit of 50.

## Retrieving All People

All of the known People may be retrieved via a `GET` request to `https://api.apptentive.com/people`.  For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/people
```

The response will contain an array of People (in ascending creation order), as well as a flag indicating whether more People are available:

```
{"people":[{"id":"5224f08cbca21f834800004e","name":"Ms. Anais Kshlerin 9","email":"ms_anais_kshlerin_94304@example.com.invalid","custom_data":{"domain":"heathcotesmitham.net","ip":"201.212.159.215","ipv6":"8577:10e5:d7df:8703:2b1e:b9b3:eb73:1b2c","suffix":"info","username":"cordell"}}],"has_more":false}
```

Each Person may include the following attributes:

* **id** The id of the given Person
* **name** The full (first and last) name of the Person
* **email** The e-mail address of the Person
* **custom_data** Person-specific key/value pairs provided by the Person creator.

The following parameters are supported to page through People:

* **skip** indicates the number of People to skip in the results.
* **limit** indicates the number of People to return in the results, with a maximum limit of 50.

## Retrieving A Specific Person

A specific Person may be retrieved via `GET` request to `https://api.apptentive.com/people/:id`, replacing `:id` with the requested Person's id. For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/people/5224f08cbca21f834800004e
```
The response will include the fields (detailed above) for the specific Person:

```
{"id":"5224f08cbca21f834800004e","name":"Ms. Anais Kshlerin 9","email":"ms_anais_kshlerin_94304@example.com.invalid","custom_data":{"domain":"heathcotesmitham.net","ip":"201.212.159.215","ipv6":"8577:10e5:d7df:8703:2b1e:b9b3:eb73:1b2c","suffix":"info","username":"cordell"}}
```

## Retrieving All Devices

All of the Devices may be retrieved via a `GET` request to `https://api.apptentive.com/devices`.  For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/devices
```

The response will contain an array of Devices (in ascending creation order), as well as a flag indicating whether more Devices are available:

```
{"devices":[{"id":"5224f08cbca21f834800004f","os_name":"iOS","os_version":"iPhone 5.0.1","os_build":"sample build","os_api_level":13,"manufacturer":"sample manufacturer","model":"sample model","board":"sample board","product":"sample porduct","brand":"sample brand","cpu":"sample cpu","hardware":null,"carrier":"T-Mobile","current_carrier":"sample current carrier","uuid":"cee9e289f4fd4210ff61062c31c1c3528c5ad962","network_type":"sample network","build_type":"sample build type","build_id":"sample build id","bootloader_version":"sample bootloader version","radio_version":"sample radio version","custom_data":{"code":"molestias","country":"Kenya","phone_id":"7UEJ","phone_number":"100.220.9123","old_uuid":"WENBZ6VUMN1HPC9V11J9"},"locale_country_code":null,"locale_language_code":null,"locale_raw":null}],"has_more":false}
```

Each Device may include the following attributes:

* **id** The id of the given Device
* **os_name** The operating system name
* **os_version** The version of the operating system
* **os_buid** The operating system build identifier
* **os_api_level** The operating system API level (Android only)
* **manufacturer** The manufacturer of the Device
* **model** The model of the Device
* **board** The name of the Device's board
* **product** The product name of the Device
* **brand** The brand of Device
* **cpu** The CPU type within the Device
* **hardware** The hardware identifier of the Device
* **carrier** The primary network carrier for the Device
* **current_carrier** The currently active network carrier
* **network_type** The type of network that the Device is currently using
* **build_type** The type of build for the Device
* **build_id** The Device build identifier
* **bootloader_versoin** The version number of the bootloader for the Device
* **radio_version** The version number for the radio firmware on the Device
* **custom_data** Device-specific key/value pairs provided by the Device creator.
* **locale_country_code** The two character country code for the Device's current locale
* **locale_language_code** The two character language code for the Device's current locale
* **locale_raw** The raw locale string for the Device
* **utc_offset** UTC offset for the timezone the Device is currently operating in in seconds

The following parameters are supported to page through Devices:

* **skip** indicates the number of Devices to skip in the results.
* **limit** indicates the number of Devices to return in the results, with a maximum limit of 50.


## Retrieving A Specific Device

A specific Device may be retrieved via `GET` request to `https://api.apptentive.com/device/:id`, replacing `:id` with the requested Device's id.  For example:

```
curl -i -H "Authorization: OAuth ea0b3686bfadf43245944e841e611c8a7d25cdd21098a9f83c3030553a593a71" https://api.apptentive.com/device/5224f08cbca21f834800004f
```

The response will include the fields (detailed above) for the specific Device:

```
{"id":"5224f08cbca21f834800004f","os_name":"iOS","os_version":"iPhone 5.0.1","os_build":"sample build","os_api_level":13,"manufacturer":"sample manufacturer","model":"sample model","board":"sample board","product":"sample porduct","brand":"sample brand","cpu":"sample cpu","hardware":null,"carrier":"T-Mobile","current_carrier":"sample current carrier","uuid":"cee9e289f4fd4210ff61062c31c1c3528c5ad962","network_type":"sample network","build_type":"sample build type","build_id":"sample build id","bootloader_version":"sample bootloader version","radio_version":"sample radio version","custom_data":{"code":"molestias","country":"Kenya","phone_id":"7UEJ","phone_number":"100.220.9123","old_uuid":"WENBZ6VUMN1HPC9V11J9"},"locale_country_code":null,"locale_language_code":null,"locale_raw":null}
```

