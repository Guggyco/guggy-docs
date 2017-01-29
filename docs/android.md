### Getting Started

#### Including Guggy in your project

Add the following, under dependencies, in your app build.gradle file:
````
repositories {
    maven {
        url 'https://dl.bintray.com/guggy/maven/'
    }
}
````

In your dependencies part of the build.gradle file add:

````
compile 'com.guggy.guggysdk:guggy:3.0.7'
````

> Highly Recommended: Add the Guggy content provider to your
AndroidManifest.xml.   
>This allows to share the GIFs via a secure content://
uri

````
<provider
    android:name="com.guggy.guggysdk.contentprovider.GuggyProvider"
    android:authorities="YOUR.PACKAGE.NAME.guggyprovider"
    android:exported="true"
    android:grantUriPermissions="true">
</provider>
````

In a starting point in your app make the following call:
````
Guggy.init(
    "YOUR_API_KEY",
    getApplicationContext()
);
````

In an exiting point in your app make the following call:

````
Guggy.destroy();
````

If you must call `Guggy.init()` without destroying, you can check  
if Guggy is already initialized by calling `Guggy.isInitialized()`.    

### Creating Media

Make a call to `createGug()`.

The returned `GuggyResult` will contain all possible URLs of stickers and animated GIFs in several formats and profiles.

````
Guggy.createGug(
    "hello",
    null, // Optional params
    new ICallback<GuggyResult>() {
        @Override
        public void onComplete(GuggyResult result) {

            // Example 1: Get all animated GIF previews
            for (AnimatedMediaResult animatedMediaResult : guggyResult.getAnimated()){

                String previewURL = animatedMediaResult.getGif().getPreview().getUrl();

                // Show preview
                yourShowImageMethod(previewURL);

            }

            // Get the final result URL of the preview to be used once the user chosen
            String finalURL = guggyResult.getAnimated().get(0).getGif().getLowQuality().getUrl();

            // Example 2: Get first result of a sticker in webp format, original profile
            guggyResult.getSticker().get(0).getWebp().getOriginal().getUrl();

            // Example 3: Get first result of an animated preview of a mp4 format with a secure URL (https)
            guggyResult.getAnimated().get(0).getMp4().getPreview().getSecureUrl();

        }

        @Override
        public void onError(Exception e) {

            // Handle error here

        }
    }
);

````

You can provide `createGug()` with a HashMap of parameters to be sent with the request.

Currently the supported options are:

`predefinedLanguage` - A two character ISO 639-1 language code that will direct Guggy to use a specific language when extracting context.

### Keyboard Developers

#### Initializing
Initializing Guggy with an InputMethodService allows fully automatic behaviour, that is,
reading the text and handling the GIF generation callback and deleting the text from the input once the result is ready.

Guggy will handle sending the correct intent for the currently-opened app or pasting the URL as text if needed.

Just call:

````
Guggy.init(
    "YOUR_API_KEY",
    this, // The InputMethodService
    getApplicationContext()
);
````

You should init at the InputMethodService's `onCreate` and destroy Guggy at the InputMethodService's `onDestroy`

#### Creating Media

To provide the user with previewed results, make a regular call to `createGug()`

Then use the result to show all possibilities.

Once the user clicks, make the following call:

````

Guggy.autoResult(
    guggyResult,
    currentPackageName, // e.g. "com.whatsapp"
    RequestType.Animated, // The selected item's type
    position, // The selected item's position in its array
    context,
    new IErrorCallback() {
        @Override
        public void onError(Exception error) {
            // handle error
        }
    }
);

````

### Proguard

Add the following to your proguard configuration:

    -keep class com.guggy.** { *; }
    -dontwarn com.guggy.**

### Permissions

For API 19 and up, only the INTERNET permission is needed.

For older APIs, the READ_EXTERNAL_STORAGE and WRITE_EXTERNAL_STORAGE permissions
are needed in order to save result files and enable other apps to use them.


### Changelog

V3.0.5

  * Increased timeout for createGug()
  * Added cancel() method to allow cancelling an autoResult operation. This will prevent from firing the intent if the request was cancelled before.
  * Fixed Viber auto result handling

V3.0.4

  * Added option to supply createGug() with parameters to be sent to the server.
  * Added support for hires GIFs
  * Added support for JPG stickers
  * Improved timeout handling
  * Removed createGugAndAutoResult(). Single media requests are now not supported. The integrating app is expected to provide the user with a preview of options to choose from.
  * Fixed crashes with mp4 files.
  * Updated AutoResult configurations to support high resolutions, added color themes for each supported app.
  * Renames:
    * GuggyAutoDetect to GuggyAutoResult
    * KeyboardRequestConfiguration to GuggyAutoResultConfiguration

V3.0.3

  * Removed permissions from SDK. It is the app's responsibility to request the necessary permissions.

v3.0.2

  * Added contextId to Animated/Sticker Media Result classes

  * Fixed getters for getDimensions()

v3.0.1

  * Complete rebuild of our SDK and API:

  * Added support for stickers

  * Added support for preview URLs (downsampled versions of media)

  * Simplification of API - No need to send a request configuration anymore, the GuggyResult will already contain all possible URLs

  * Support Google Allo, Viber in keyboard auto result

  * Local URI Mode is now supported only for keyboards
