module UrlExpander
  module Expanders
    
    #
    # Expand Budurl URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://budurl.com/EYOS2")
    #
    class Budurl < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://budurl.com/EYOS2 => 'EYOS2' without /
      PATTERN = %r'(http://budurl\.com/([\w/]+))'
      
      attr_reader :parent_klass
      
      def initialize(short_url, options={})
        @parent_klass = self.class
        super(short_url,options)
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'budurl.com'
        format :json
      end
      
      
      private
      
      def fetch_url
        data = JSON.parse Request.get("/api/v1/budurls/expand?budurl=#{@shortner_key}").response.body
        if(data["success"] == 1)
          @long_url = data["long_url"]
        else
          raise UrlExpander::Error.new(data['error_message'],data['error_code'])
        end
      end
    end
  end
end