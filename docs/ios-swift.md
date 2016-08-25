### Getting Started

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