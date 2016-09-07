### Including Guggy

#### NPM Module
`npm install --save @guggy/guggy-js-sdk`

#### Including the SDK in your site
Include the script tag:
````
<script src="https://cdn.rawgit.com/Guggyco/guggy-web-sdk/1.4.0/guggy-sdk.min.js"></script>
````

### Initializing Guggy

Options are:

`apiKey` - __Mandatory__

`onStart` - Optional callback to be excuted when the GIF generation starts.

`userId` - A unique identifier of your user

````
Guggy.init({
    opts
});
````

### Creating GIFs

If you're using the direct API, just initialize with the `apiKey` option.

Then call Guggy whenever's needed:

````
Guggy.createGug(sentence, function (result, err) {
   // Handle result
});
````

### Previewing background GIF

You can preview the background GIF as the user types.

>The preview is in mp4 format.

Call `Guggy.onType` on your keyDown or equivalent event.

Parameters that will be passed to the callback:

`mediaItem` - The media item containing the url of the video which matches the preview.
Will be __null__ if the context extracted is equal to the last result.

````
Guggy.onType(input.value, function (mediaItem) {

    if (mediaItem) {

        someVideoElement.src = mediaItem.url;

    }

})
````

Calling `Guggy.createGug()` will produce the GIF according the last result previewed.

### Getting a random GIF

If you need an initial GIF to show in the preview before the user is typing, call:

````
Guggy.getRandomGIF(function(item, err){

    someVideoElement.src = item.url;

})
````