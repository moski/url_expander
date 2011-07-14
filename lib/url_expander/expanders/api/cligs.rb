module UrlExpander
  module Expanders
    
    #
    # Expand Cligs URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://cli.gs/2BAzKa")
    #
    class Cligs < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://cli.gs/2BAzKa => '2BAzKa' without /
      PATTERN = %r'(http://cli\.gs/([\w/]+))'
      
      attr_reader :parent_klass
      
      def initialize(short_url, options={})
        @parent_klass = self.class
        super(short_url,options)
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'cli.gs'
      end
      
      
      private
      
      def fetch_url
        response = Request.get("/api/v1/cligs/expand?clig=#{@shortner_key}").response
        
        case response.response
          when Net::HTTPOK
            @long_url = response.body
          else
            raise UrlExpander::Error.new(response.body,response.code)
        end
      end
    end
  end
end