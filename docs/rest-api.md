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