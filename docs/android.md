### Getting an API Key
Our API is free. Contact us at __api@guggy.com__ to retrieve an API Key.

### Including Guggy in your project

Add the following, under dependencies, in your app build.gradle file:
````
repositories {
    maven {
        url 'https://dl.bintray.com/guggy/maven/'
    }
}
````

In your dependencies part of the build.gradle file add:

     compile 'com.guggy.guggysdk:guggy:1.0.1'

> Highly Recommended: Add the Guggy content provider to your
AndroidManifest.xml. <br> This allows to share the GIFs via a secure content://
uri

    <provider
        android:name="com.guggy.guggysdk.contentprovider.GuggyProvider"
        android:authorities="YOUR.PACKAGE.NAME.guggyprovider"
        android:exported="false"
        android:grantUriPermissions="true">
    </provider>

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

You can now use Guggy to create GIFs.

### Creating GIFs

There are two options for creating GIFs:

`GuggyButton` — A view which handles the API call to Guggy.

`GuggyCore` — Allows to make the API call directly, but you
would need to implement the view yourself.

#### GuggyButton

1.  Place the button, either in a layout file or by creating it programmatically.
For example

    GuggyButton guggyButton = new GuggyButton();

2. Define a callback to retrieve the text once the button is clicked:

    guggyButton.setRetrieveTextFunction(
    IRetrieveTextFunction() {
        @Override

    String getText() {

    myEditText.getText()
        }
    });

3. Set the RequestConfigurationCallback — which sets the request parameters —
File format (MP4 or GIF), Result URI mode (Local File, Local Content, Remote
URI) and result handler (Paste URL, Share Intent or a custom which you can
define).

    guggyButton.setRequestConfigurationCallback(
    IRequestConfigurationCallback() {
        @Override

    RequestConfiguration getRequestConfiguration() {


    RequestConfiguration(
                    FileFormat.
    ,
                    URIMode.
    );

        }
    });

4. Set the result callback , which is called once the GIF is ready:

    guggyButton.setCallback(
    ITwoParamsCallback<Result, RequestConfiguration>() {
        @Override

    onComplete(Result result, RequestConfiguration requestConfiguration) {

            String gifURL = result.getUrl();

            // Insert in your app

        }

        @Override

    onError(Exception e) {

    }
    });

#### Guggy Core

In your onClick handler, make the following call:

    Guggy.
    (
            someString,

    RequestConfiguration(
                    FileFormat.
    ,
                    URIMode.
    ),
            getApplicationContext(),

    ITwoParamsCallback<Result, RequestConfiguration>() {
                @Override

    onComplete(Result result, RequestConfiguration requestConfiguration) {
                    String generatedURL = result.getUrl();
                }
                @Override

    onError(Exception e) {
                }
            }
    );

You can also send a Bitmap as the first parameter in order to use that image as
the GIF background.

Note that the Guggy logo should be used as an image for the button.

#### Result Preview

You can allow your users to choose the GIF background before generating the
result. You can expect between one and four results to show the user.

Use the following method:

    Guggy.
    (getTheText(), getApplicationContext(),
    ICallback<GetMediaResult>() {
        @Override

    onComplete(GetMediaResult result) {
            MediaItem mediaItem = result.getMedia().get(0);
    Guggy.
    (
                    result.getReqId(),
                    mediaItem,
                    getTheText(),

    RequestConfiguration(FileFormat.
    , URIMode.
    ),
                    getApplicationContext(),

    ITwoParamsCallback<CreateGugResult, RequestConfiguration>() {
                        @Override

    onComplete(CreateGugResult gugResult, RequestConfiguration requestConfiguration) {
                            String url = gugResult.getUrl();
                        }
                        @Override

    onError(Exception error) {
                            String err = error.getMessage();
                        }
                    }
            );
        }
        @Override

    onError(Exception error) {

    }
    });

### Proguard

Add the following to your proguard configuration:

    -keep class com.guggy.** { *; }
    -dontwarn com.guggy.**

### Permissions

For API 19 and up, only the INTERNET permission is needed.

For older APIs, the READ_EXTERNAL_STORAGE and WRITE_EXTERNAL_STORAGE permissions
are needed in order to save result files and enable other apps to use them.
