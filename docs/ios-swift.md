### Getting Started

#### Including Guggy in your project

Guggy SDK is based on the Swift 3 language.

In your `podfile`, insert the following line:
````
pod 'guggysdk' , "~> 1.0.2"
````

In every file referencing Guggy add the following

````
import guggysdk
````

In a starting point in your app make the following call:
````
try! Guggy.initialize(YOUR_API_KEY_HERE) // Throws an AlreadyInitialized error
````

In an exiting point in your app make the following call:

````
Guggy.destroy();
````

### Creating GIFs

Make a call to `createGug()`.
The returned `GuggyResult` will contain all possible URLs of stickers and animated GIFs in several formats and profiles.

````
createGug(text:String?, onComplete: (GuggyResult?) -> Void)
````

Example:
````
Guggy.createGug(textField.text) { guggyResult in

    // Handle result
     // Example 1: Get all animated GIF previews
    for animatedResult in result.animated! {

        let previewURL = animatedResult.gif?.preview?.url

        // Show preview
        yourShowImageMethod(previewURL);

    }

    // Get the final result URL of the preview to be used once the user chosen
    let finalURL = guggyResult.animated?[0].gif?.lowQuality?.url

    // Example 2: Get first result of a sticker in webp format, original profile
    guggyResult.sticker?[0].webp?.original?.url

    // Example 3: Get first result of an animated preview of a mp4 format with a secure URL (https)
    guggyResult.animated?[0].mp4.preview.secureUrl

}
````

### Changelog

V1.0.2

  * Support for nil sentence parameter in createGug
