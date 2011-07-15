module UrlExpander
  module Expanders
    
    #
    # Expand Isgd URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://is.gd/wsJRhR")
    #
    class Isgd < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://is.gd/wsJRhR => 'wsJRhR' without /
      PATTERN = %r'(http://is\.gd/([\w/]+))'
      
      attr_reader :parent_klass
      
      def initialize(short_url, options={})
        @parent_klass = self
        super(short_url,options)
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'is.gd'
        format :json
      end
      
      
      private
      
      def fetch_url
        data = JSON.parse Request.get("/forward.php?format=json&shorturl=http://is.gd/#{@shortner_key}").response.body
        unless(data["errorcode"])
          @long_url = data["url"]
        else
          raise UrlExpander::Error.new(data['errormessage'],data['errorcode'])
        end
      end
    end
  end
end