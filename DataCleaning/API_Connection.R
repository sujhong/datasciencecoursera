# for twitter
myapp = oauth_app("twitter",
                  key= "yourConsumerKeyHere",
                  secret = "yourConsumerSecreteHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

# convert the json object to extract Json data
json = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

