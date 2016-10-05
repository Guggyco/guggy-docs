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
compile 'com.guggy.guggysdk:guggy:2.0.5'
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

### Previewing Results

In order to integrate Guggy as a GIF provider, you can use the preview API as the user types to receive a downsampled version of the GIF.

Use the following method:

````
String lastReqId;

// Preview - call this method onType or equivalent method
Guggy.preview(
    getTheText(), 
    new RequestConfiguration(FileFormat.MP4, URIMode.LocalFile), 
    getApplicationContext(), 
    new ITwoParamsCallback<GuggyResult, RequestConfiguration>() {
        @Override
        public void onComplete(final GuggyResult guggyResult, final RequestConfiguration requestConfiguration) {
    
            // You need to send the same reqId when generating the final result
            lastReqId = guggyResult.getReqId(); 
            
        }
    
        @Override
        public void onError(Exception error) {
    
            // Handle
            
        }
    }
);

// When the user has chosen, provide the request ID

Guggy.createGug(
        lastReqId,
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

And on your keyboard button click just call

````
Guggy.createGug();
````

You should init at the InputMethodService's `onCreate` and destroy Guggy at the InputMethodService's `onDestroy`

#### Previewing Results

For keyboards the API is a bit simplified:

````

Guggy.preview(
    new RequestConfiguration(FileFormat.GIF, URIMode.Remote),
    new ITwoParamsCallback<GuggyResult, RequestConfiguration>() {
        @Override
        public void onComplete(GuggyResult guggyResult, RequestConfiguration requestConfiguration) {

            // Show preview

        }

        @Override
        public void onError(Exception e) {

        }
});

// When the use has chosen just call:

Guggy.createGug(guggyResult.getReqId());

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
