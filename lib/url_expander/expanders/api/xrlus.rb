module UrlExpander
  module Expanders
    
    #
    # Expand Xrl.us URLS -- http://metamark.net/
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://xrl.us/bkz5iy")
    #
    class Xrlus < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://xrl.us/bkz5iy => 'bkz5iy' without /
      PATTERN = %r'(http://xrl\.us/([\w/]+))'
      
      attr_reader :parent_klass, :short_url
      
      def initialize(short_url, options={})
        @parent_klass = self
        @short_url = short_url
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'metamark.net'
      end
      
      
      private
      
      def fetch_url
        data = Request.get("/api/rest/simple?short_url=#{@short_url}").response.body
        unless(data[0..5] == 'ERROR:')
          @long_url = data
        else
          raise UrlExpander::Error.new(data,404)
        end
      end
    end
  end
end