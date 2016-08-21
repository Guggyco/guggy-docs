### Getting Started

#### Getting an API Key
Our API is free. Contact us at __api@guggy.com__ to retrieve an API Key.

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
compile 'com.guggy.guggysdk:guggy:1.0.1'
````

> Highly Recommended: Add the Guggy content provider to your
AndroidManifest.xml.   
>This allows to share the GIFs via a secure content://
uri

````
<provider
    android:name="com.guggy.guggysdk.contentprovider.GuggyProvider"
    android:authorities="YOUR.PACKAGE.NAME.guggyprovider"
    android:exported="false"
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

### Creating GIFs

There are two options for creating GIFs:

__GuggyButton__ — A view which handles the API call to Guggy.

__Direct API__ — Allows to make the API call directly, but you
would need to implement the view yourself.<br/><br/>

#### GuggyButton

Place the button, either in a layout file or by creating it programmatically.
For example

    GuggyButton guggyButton = new GuggyButton();

Define a callback to retrieve the text once the button is clicked:

````
guggyButton.setRetrieveTextFunction(new IRetrieveTextFunction() {
    @Override
    public String getText() {
        return myEditText.getText()
    }
});
````

Set the RequestConfigurationCallback, which sets the request parameters:  
File format (MP4 or GIF), Result URI mode (Local File, Local Content, Remote
URI) and result handler (Paste URL, Share Intent or a custom which you can
define).

````
guggyButton.setRequestConfigurationCallback(new IRequestConfigurationCallback() {
    @Override
    public RequestConfiguration getRequestConfiguration() {
        return new RequestConfiguration(
                FileFormat.GIF,
                URIMode.LocalContentProvider
        );
    }
});
````

Set the result callback , which is called once the GIF is ready:

````
guggyButton.setCallback(new ITwoParamsCallback<Result, RequestConfiguration>() {
    @Override
    public void onComplete(Result result, RequestConfiguration requestConfiguration) {
        String gifURL = result.getUrl(); 
        // Insert in your app
        
    }
    @Override
    public void onError(Exception e) {
        // We didn't make it
    }
});
````

<br/>

#### Direct API

In your onClick handler, make the following call:

````
Guggy.createGug(
        someString,
        new RequestConfiguration(
                FileFormat.MP4,
                URIMode.LocalContentProvider
        ),
        getApplicationContext(),
        new ITwoParamsCallback<Result, RequestConfiguration>() {
            @Override
            public void onComplete(Result result, RequestConfiguration requestConfiguration) {

                String generatedURL = result.getUrl();

            }

            @Override
            public void onError(Exception e) {

            }
        }
);
````

Note that the Guggy logo should be used as an image for the button.

#### Media Preview

You can allow your users to choose the GIF background before generating the
result. You can expect between one and four results to show the user.

Use the following method:

````
Guggy.getMedia(getTheText(), getApplicationContext(), new ICallback<GetMediaResult>() {
    @Override
    public void onComplete(GetMediaResult result) {

        MediaItem mediaItem = result.getMedia().get(0); // Show the results to the user
        
        // When the user has chosen, provide the request ID and the selected MediaItem
        Guggy.createGug(
                result.getReqId(),
                mediaItem,
                getTheText(),
                new RequestConfiguration(FileFormat.MP4, URIMode.Remote),
                getApplicationContext(),
                new ITwoParamsCallback<CreateGugResult, RequestConfiguration>() {
                    @Override
                    public void onComplete(CreateGugResult gugResult, RequestConfiguration requestConfiguration) {

                        String url = gugResult.getUrl();

                    }

                    @Override
                    public void onError(Exception error) {

                        String err = error.getMessage();

                    }
                }
        );

    }

    @Override
    public void onError(Exception error) {

        // Handle
        
    }
});
````

### Keyboard Developers

#### Initializing
Initializing Guggy with an InputMethodService allows fully automatic behaviour, that is,  
reading the text and handling the GIF generation callback.

Just call:

````
Guggy.init(
        "YOUR_API_KEY",
        this, // The InputMethodService
        getApplicationContext()
);
````

#### GuggyKeyboardButton    

All that is needed is to create the button (via layout or programmatically).
 
Adding the button on top of a `KeyboardView` is possible. If that's what you want to achieve,
let us know for directions.


````
guggyKeyboardButton.setRequestConfigurationCallback(new IRequestConfigurationCallback() {
    @Override
    public RequestConfiguration getRequestConfiguration() {

        // You can still get the auto detected configuration and inspect it
        RequestConfiguration auto = guggyKeyboardButton.getAutoDetectedConfiguration();

        return new RequestConfiguration(
                FileFormat.GIF,
                URIMode.LocalContentProvider
        );

    }
});
````


#### Direct API

If you wish to implement your own View component, you can stil call the direct API, like so:

````
Guggy.createGug();
````

#### Media Preview

The API is a bit simplified compared to non-keyboard implementations:
````
Guggy.getMedia(new ICallback<GetMediaResult>() {
    @Override
    public void onComplete(GetMediaResult getMediaResult) {
       // Allow the user to choose the MediaItem 
       MediaItem mediaItem = getMediaResult.getMedia().get(0);

      // When ready, make the following call
      Guggy.createGug(getMediaResult.getReqId(), mediaItem);
    }

    @Override
    public void onError(Exception e) {

    }
});
````

### Notes

#### Proguard

Add the following to your proguard configuration:

    -keep class com.guggy.** { *; }
    -dontwarn com.guggy.**

#### Permissions

For API 19 and up, only the INTERNET permission is needed.

For older APIs, the READ_EXTERNAL_STORAGE and WRITE_EXTERNAL_STORAGE permissions
are needed in order to save result files and enable other apps to use them.
