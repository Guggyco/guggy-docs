### Getting Started

#### Including Guggy in your project

Guggy SDK is based on the Swift 3 language.

In your `podfile`, insert the following line:
````
pod 'guggysdk' , "~> 1.0.10"
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

Build a `GuggyRequest` object and then make a call to `createGug()`.

The returned `GuggyResult` will contain all possible URLs of stickers and animated GIFs in several formats and profiles.

````
createGug(GuggyRequest, (GuggyResult?) -> Void)
````

The GuggyRequestBuilder supports these methods:

`sentence(String)` - The text to be overlaid on the media and to be used when extracting context

`hiddenMeaning(String)` - Adds a hidden meaning, such that the background media will be chosen by it, but the sentence() text will appear on the media

`noText()` - Requests that no text will be attached to media

`invertMeaning()` - Directs the engine to extract inverted/cynical contexts

`lang(String)` - Allows sending two character ISO 639-1 language code that will direct Guggy to use a specific language when extracting context and trending content

Example:

````

let request = GuggyRequestBuilder()
            .sentence(textField.text)
            .hiddenMeaning(hiddenMeaningTextField.text)
            .build()

Guggy.createGug(request) { guggyResult in

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

### Trending Results

To get trending sentences don't include a `sentence()` call in the request builder.

Providing a `lang` parameter will affect the results.

### Changelog

V1.0.10

  * Added GuggyRequest class and new request features.

V1.0.4

  * Added support for user parameters

V1.0.2

  * Support for nil sentence parameter in createGug
