# Guggy Integration Guideline & Recommendations

## Prologue
This document is a guideline and provides recommendations for companies who want to integrate Guggy in their product and are coming from a product point of view.

Technical aspect guidelines can be found at our [docs](http://docs.guggy.com).

## Method of integration

### Preview results after action
The user needs to perform a specific action (like pressing a button) to preview the results. A good use case is to show the user a Guggy button near the send button to indicate that they are related.
Tapping on the Guggy button will preview results according to the user’s text message.

Examples for this method of integration can be found in apps such as [Guggy FunApp](https://play.google.com/store/apps/details?id=com.guggy.funapp), [Sila Messenger](https://play.google.com/store/apps/details?id=com.appmahal.chat),
[a.i. type keyboard](http://aitype.com/), [BobbleApp](https://bobbleapp.me/home) and more.

Another example for a use case can be a long press on the send button to preview the results. However, in that case the user should be indicated somehow that he can perform this action.

####Examples
|![Demo](http://res.guggy.com/docs_resources/impl_guideline/button_1.jpg)|![Demo](http://res.guggy.com/docs_resources/impl_guideline/button_2.jpg)|
|---|---|

## Rules and guidelines

#### Language support
Guggy supports over 30 languages, but natively supports and will perform best in English.

#### Sending the __userId__ parameter
This parameter can be scrambled and hashed but has to be unique for each user in order to have features such as “displaying a specific result to a user once” and others like that.

#### Fetching and displaying only the shown results
This mechanism is very efficient and will reduce the number of times and data the user fetches from the servers. You can see an example for this mechanism in Guggy FunApp where while scrolling horizontally the new results are being loaded.

#### Order of rendering while previewing
In order to improve the user experience it is recommended to first show the thumbnail of the result and then the preview version. Please notice that only the __preview version__ is allowed to be used while previewing.

#### Correct order of display after user selected a result
It is very important to first display the preview result (since the use already have it on his device) and then replace it with the low res, original or high resolution version, depending on the bandwidth (3G, 4G, wifi) of the user. Example for this can be shown in Hop messenger.

* Please notice that as for now we cannot guarantee a lifetime retention of the shared GIFs.