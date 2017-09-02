require 'rest-client'
require 'json'

# Datumbox Wrapper.
# Before use it, you must register yourself at Datumbox site
# and get your API Key.
#
# Create an instance of this class calling "Datumbox.create(api_key)".
#
# Author: Pedro Damian Kostelec
#
# Some of the available methods are:
# (See the API documentation [http://www.datumbox.com/api-sandbox/] for an exhaustive list of methods)
#
# sentiment_analysis(text)
#   Classifies "text" as positive, negative or neutral.
#
# subjective_analysis(text)
#   Categorizes "text" as subjective or objective based on writing style.
#   Texts that express personal opinions are labeled as subjective and the others as objective.
#
# spam_detection(text)
#   Labels documents as spam or nospam by taking into account their context.
#
# adult_content_detection(text)
#   Classifies documents as adult or noadult based on their context.
#
# topic_classification(text)
#   Assigns documents in 12 thematic categories based on ther keywords, idioms and jargon.
#
# language_detection(text)
#   Identifies the natural language of the given text based on its words and context.
#
# twitter_sentiment_analysis(text)
#   Classifies "text" as positive, negative or neutral.
#
# keyword_extraction(text, n)
#   Enables you to extract from an arbitrary document all the keywords and word
#   combinations along with their occurrences in the text.
#
# document_similarity(original, copy)
#   Estimates the degree of similarity between two documents.

class Datumbox

  BASE_URI = 'http://api.datumbox.com/'
  API_VERSION = '1.0'

  def initialize(api_key)
    @api_key = api_key
  end

  # Get a Wrapper instance to access the Datumbox service.
  # You must give your API Key once.
  #
  def self.create(api_key)
    Datumbox.new(api_key)
  end

  def request(method, opts)
    options = { api_key: @api_key }.merge opts
    RestClient.post "#{BASE_URI}#{API_VERSION}/#{method}.json", options
  end

  def sentiment_analysis(text='hello')
    body = {'text' => text}
    args = {content_type: :json, accept: :json}
    request(sentiment_analysis, body, args)
  end

end
