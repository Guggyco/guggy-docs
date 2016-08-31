### Getting Started

#### Including Guggy in your project

In your `podfile`, insert the following line:
````
pod 'guggysdk' , "~> 0.0.7"
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

In your onClick handler, make one of the following calls, according to your needs:

````
Guggy.createGug(text:String, format: ResultFormat, skipDownload: Bool, onComplete:(GuggyResult?) -> Void)
````

Options:

`format` - Either GIF or MP4

`skipDownload` - Whether to return a local URL and NSData for the file created

Example:
````
Guggy.createGug(textField.text!, format: .GIF, skipDownload: false) { result in

    // Handle result

}
````

The result will contain the following fields:

`url` - Remote URL of the generated media

`localUrl` - Local URL of the generated media. *Will be `nil` if download was skipped*

`data` - NSData of the generated media. *Will be `nil` if download was skipped*

`width` - Width of media

`height` - Height of media

### Previewing background GIF

You can preview the background GIF as the user types.

>The preview is in mp4 format.

Call `onType(text:String, onStart:(()->())?, onComplete: (String?)` on your keyDown or equivalent event.

Options:

`onStart` - A callback which is fired when Guggy starts searching for media. *Not every call to `onType` will cause a media search due to debouncing*

`onComplete` - A callback which is fired once the media search is over with a String containing a URL to the local mp4 file which can be played using AVLayer.
If the context extracted is equal to the last context extraction request, the url will be `nil`

Example:
````
Guggy.onType(textView.text, onStart: {self.activityIndicatorView.startAnimating()}) { url -> Void in

    if let url = url {

        self.videoView.play(
            NSURL(string: url)!,
            aspectFill: false,
            onPlay: onPlay
        )

    }

}
````

Subsequent calls to `Guggy.createGug` will use the last video extracted as the GIF background.

> Note that the Guggy logo should be used as an image for the button used to create the GIFs