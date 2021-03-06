### Getting Started

### Creating GIFs
Send a POST request to 
````
http://text2gif.guggy.com/v2/guggify
````

The request headers should include:
````
{
    "Content-Type":"application/json",
    "apiKey":"YOUR_API_KEY"
}
````

The request body can contain:
````
{
    "sentence" : "some sentence",
    "lang": "ru"
}
````

The response will contain an array of results in all supported formats for either a sticker or an animated GIF.

You can use all preview URLs for example to display the user a choice of several GIFs and stickers.

You can provide the request with parameters.

Currently the supported parameters are:

`lang` - A two character ISO 639-1 language code that will direct Guggy to use a specific language when extracting context and trending content.


````
{
  "reqId": "HrKANFARqj",
  "animated": [
    {
      "gif": {
        "hires": {
          "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/h/guggy.gif",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/h/guggy.gif",
          "dimensions": {
            "width": 250,
            "height": 180
          }
        },
        "preview": {
          "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/p/guggy.gif",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/p/guggy.gif",
          "dimensions": {
            "width": 130,
            "height": 94
          }
        },
        "lowQuality": {
          "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/l/guggy.gif",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/l/guggy.gif",
          "dimensions": {
            "width": 250,
            "height": 180
          }
        },
        "original": {
          "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/o/guggy.gif",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/o/guggy.gif",
          "dimensions": {
            "width": 250,
            "height": 180
          }
        }
      },
      "mp4": {
         "hires": {
            "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/h/guggy.gif",
            "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/h/guggy.gif",
            "dimensions": {
              "width": 250,
              "height": 180
            }
        },
        "original": {
          "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/o/guggy.mp4",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/o/guggy.mp4",
          "dimensions": {
            "width": 250,
            "height": 180
          }
        },
        "preview": {
          "url": "http://img.guggy.com/media/HrKANFARqj/animated/0/p/guggy.mp4",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/animated/0/p/guggy.mp4",
          "dimensions": {
            "width": 130,
            "height": 94
          }
        }
      },
      "thumbnail": {
        "original": {
          "url": "http://guggyrepository.guggy.com/NbPBGAkQToGyOdGtLUHJ.jpg",
          "secureUrl": "https://guggyrepository.guggy.com/NbPBGAkQToGyOdGtLUHJ.jpg",
          "dimensions": {
            "width": 250,
            "height": 180
          }
        }
      }
    },
    ...
  ],
  "sticker": [
    {
      "webp": {
        "hires": {
          "url": "http://img.guggy.com/media/HrKANFARqj/sticker/0/h/guggy.webp",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/sticker/0/h/guggy.webp",
          "dimensions": {
            "width": 512,
            "height": 512
          }
        },
        "original": {
          "url": "http://img.guggy.com/media/HrKANFARqj/sticker/0/o/guggy.webp",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/sticker/0/o/guggy.webp",
          "dimensions": {
            "width": 256,
            "height": 256
          }
        },
        "preview": {
          "url": "http://img.guggy.com/media/HrKANFARqj/sticker/0/p/guggy.webp",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/sticker/0/p/guggy.webp",
          "dimensions": {
            "width": 128,
            "height": 128
          }
        }
      },
      "png": {
        "hires": {
          "url": "http://img.guggy.com/media/HrKANFARqj/sticker/0/h/guggy.png",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/sticker/0/h/guggy.png",
          "dimensions": {
            "width": 512,
            "height": 512
          }
        },
        "original": {
          "url": "http://img.guggy.com/media/HrKANFARqj/sticker/0/o/guggy.png",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/sticker/0/o/guggy.png",
          "dimensions": {
            "width": 256,
            "height": 256
          }
        },
        "preview": {
          "url": "http://img.guggy.com/media/HrKANFARqj/sticker/0/p/guggy.png",
          "secureUrl": "https://img.guggy.com/media/HrKANFARqj/sticker/0/p/guggy.png",
          "dimensions": {
            "width": 128,
            "height": 128
          }
        }
      }
    },
    ...
  ]
}
````

### Getting trending results

Sending a `/guggify` request with no `sentence` param will return trending results.
Providing a `lang` parameter will affect the results.