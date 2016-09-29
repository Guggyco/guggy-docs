### Getting Started

### Creating GIFs
Send a POST request to 
````
http://text2gif.guggy.com/guggify
````

The request headers should include:
````
{
    "Content-Type":"application/json",
    "apiKey":"YOUR_API_KEY"
}
````

The request body should contain:
````
{
    "format": "mp4", // either "gif" or "mp4"
    "sentence" : "some sentence"
}
````

The response will be in the format of:
````
{
  "reqId": "5Ow7Ej46Sy",
  "mp4": "https://i.guggy.com/SOMETHING.mp4", // or GIF
  "width": 300,
  "height": 238
}
````

### Previewing Results

In order to integrate Guggy as a GIF provider, you can use the preview API as the user types to receive a downsampled version of the GIF.

Send a POST request to
````
http://text2gif.guggy.com/preview
````

Using the same headers and request body as a regular GIF create request.

The response will return a __reqId__ value.

To generate the final high quality GIF, send a create GIF request as described above with the addition of a __reqId__ parameter which contains the value returned by the preview request.


