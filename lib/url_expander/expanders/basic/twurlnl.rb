module UrlExpander
  module Expanders
    
    #
    # Expand Twurl.nl URLS
    # Usage:
    # UrlExpander::Client.expand("http://twurl.nl/e6mglc")
    #
    class Twurlnl < UrlExpander::Expanders::Basic
      
      PATTERN = %r'(http://twurl\.nl(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="",options={})
        @parent_klass = self
        super(short_url,options)
      end
      
      # Custom fetcher.
      def fetch_url(path)
        url = super(path)
        raise UrlExpander::Error.new('page not found',404) if url == "http://tweetburner.com/pages/blocked"
        url
      end
      
      
      class Request
        include HTTParty
        base_uri 'http://twurl.nl'
      end
      
    end
  end
end