module UrlExpander
  module Expanders
    
    #
    # Expand Google URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://goo.gl/DRppM")
    #
    class Googl < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://goo.gl/DRppM => 'DRppM' without /
      PATTERN = %r'(http://goo\.gl/([\w/]+))'
      
      attr_reader :parent_klass
      
      def initialize(short_url, options={})
        @parent_klass = self
        super(short_url,options)
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'https://www.googleapis.com'
        headers 'Content-Type' => 'application/json'
        headers "Content-length" => "0"
      end
      
      
      private
      
      def fetch_url
        response = Request.get("/urlshortener/v1/url?shortUrl=http://goo.gl/#{@shortner_key}")
        if response.code == 200
          @long_url  = response['longUrl']
        else
          error = (JSON.parse response.body)['error']
          raise UrlExpander::Error.new(error['message'],response.code)
        end
      end
    end
  end
end