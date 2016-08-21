### Getting Started

#### Including the SDK in your site
Include the script tag:
````
<script src="https://cdn.rawgit.com/Guggyco/guggy-web-sdk/master/guggy-sdk-min.js"></script>
````

#### Initializing Guggy

Options are:

`apiKey` - __Mandatory__

`typeMode` - Allow sending keystrokes to Guggy in order to retrieve a preview of the GIF background

`retrieveTextFunction` - Tell Guggy which text to use when creating the GIF. __Mandatory if using GuggyButton.__

`onStart` - Optional callback to be excuted when the GIF generation starts.

`onSuccess` - Optional callback to be excuted when the GIF generation completes. *Only applicable if not using the preview*

`showPreview` - If using GuggyButton a preview will be shown. *default: false*,

`onSelectFunction` - Callback to be executed when clicking on the item in the preview.

````
Guggy.init({
    opts
});
````

### GuggyButton

Add the button to your page:
````
var div = document.getElementById('yourContainer');

div.appendChild(Guggy.GuggyButton);
````

### Previewing results

You can preview the background GIF as the user types.

>The preview is in mp4 format.

Init Guggy with the `typeMode` option set to `true`

Then call `Guggy.onType` on your keyDown or equivalent event.

````
Guggy.onType(input.value, function (reqId, mediaItem) {

    // If the result was equal to the last result, reqId will be null
    if (reqId) {

        someVideoElement.src = mediaItem.url;

    }

})
````

Pressing on GuggyButton will produce the GIF according the last result previewed.

### Direct API

If you're using the direct API, just initialize with the `apiKey` option.

Then call Guggy whenever's needed:

````
Guggy.createGug(sentence, function (result, err) {
   // Handle result
});
````