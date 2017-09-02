#!/usr/bin/env ruby

require 'rubygems'
require 'twitter'
require 'pp'
require 'rest-client'
require 'json'

#Datumbox config
BASE_URI = 'http://api.datumbox.com/'
API_VERSION = '1.0'

#RestClient.proxy = "http://127.0.0.1:8080"

#Twitter config
#register here: https://apps.twitter.com/
#add your info here
client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ""
    config.consumer_secret     = ""
    config.access_token        = ""
    config.access_token_secret = ""
end

api_key = 'DATUMBOX API KEY'

# What is the sentiment, positive, negative, neutral
def sentiment(text)
  RestClient.post "http://api.datumbox.com/1.0/SentimentAnalysis.json", {api_key: '', text: text}, {content_type: :json, accept: :json}
end

# What is the degree of readability, basic, intermediate and advanced
def readability(text)
  RestClient.post "http://api.datumbox.com/1.0/ReadabilityAssessment.json", {api_key: '', text: text}, {content_type: :json, accept: :json}
end

def today?(tweet)
  Date.parse(tweet.created_at.strftime('%Y/%m/%d')) == Date.parse(Time.now.strftime('%Y/%m/%d'))
end

tweets = client.user_timeline("realDonaldTrump")

tweets.each do |tweet|
  if today?(tweet)
    sentiment_json = JSON.parse(sentiment(tweet.text))
    readability_json = JSON.parse(readability(tweet.text))
    puts tweet.text
    puts "Sentiment: " + sentiment_json["output"]["result"]
    puts "Readability: " + readability_json["output"]["result"]
    puts
  end
end
