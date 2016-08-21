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

### Media Preview

You can allow your users to choose the GIF background before generating the
result. You can expect between one and four results to show the user.

Send a POST request to 
````
http://text2gif.guggy.com/extractMedia
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
    "sentence" : "some sentence"
}
````

The response will be in the format of:
````
{
  "reqId": "QAOMfoLzbo",
  "media": [
    {
      "url": "http://url1.mp4",
      "dimensions": {
        "width": 480,
        "height": 270
      },
      "isStillImage": false,
      "ratio": 0.5625
    },
    ... // More results
  ]
}    
````

Once choosing one of the URLs, make another request to:
````
http://text2gif.guggy.com/guggify
````

With the same headers.

The request body should be in the format of:
````
{
    "format": "mp4", // either "gif" or "mp4"
    "sentence" : "some sentence",
    "reqId": "QAOMfoLzbo", // use same req id from mediaExtract response
    "predefinedSource": {
        "url": "http://image1.mp4", // chosen url 
        "canvasDimensions": { // dimensions of chosen 
            "width": 500,
            "height": 393
        },
        "isStillImage": false // same as from extractMedia response
    }
}
````