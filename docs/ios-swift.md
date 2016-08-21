### Getting Started

#### Getting an API Key
Our API is free. Contact us at __api@guggy.com__ to retrieve an API Key.

#### Including Guggy in your project

In your `podfile`, insert the following line:
````
pod ‘guggysdk’, ‘~> 0.0.1
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

There are two options for creating GIFs:

__GuggyButton__ — A UIButton which handles the API call to Guggy.

__Direct API__ — Allows to make the API call directly, but you
would need to implement the view yourself.<br/><br/>

#### GuggyButton

Choose one of the variations of GuggyButton:

__GuggyRetrieveFileButton__ - Returns NSData representation of the GIF
 
__GuggyCopyToClipboardButton __ - Places the GIF data in clipboard

__GuggyRetrieveURLButton__ - Returns the URL for the GIF

Place the button by creating it programmatically (Not supported via Interface Builder). For example:

````
let guggyButton = GuggyRetrieveFileButton(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
````

Define a callback to retrieve the text once the button is clicked:

````
guggyButton.retrieveTextCallback = {
            
    return self.textField.text!
            
}
````

Set the result callbacks , which are called once the GIF is ready:

````
guggyButton.onSuccessCallback = { resultNSData in
            
   self.imageView.image = UIImage.gifWithData(resultNSData)
            
}
        
guggyButton.onErrorCallback = { err in
            
    print(err)
            
}
````

<br/>

#### Direct API

In your onClick handler, make one of the following calls, according to your needs:

````
Guggy.createGugAndRetrieveFile(text: String, onSuccess: NSData -> Void, onError: String -> Void)
Guggy.createGugAndCopyToClipboard(text: String, onSuccess: Void -> Void, onError: String -> Void)
Guggy.createGugAndRetrieveURL(text: String, onSuccess: guggysdk.Result -> Void, onError: String -> Void)
````

For example:
````
Guggy.createGugAndRetrieveURL(
            
    textField.text!,
    onSuccess: {
        result in
        print(result.url)
    },     
    onError: {
        err in
        print(err)       
     }   
)
````

Note that the Guggy logo should be used as an image for the button.