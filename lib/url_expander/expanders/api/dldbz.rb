module UrlExpander
  module Expanders
    
    #
    # Expand dld.bz URLS
    # Usage:
    # UrlExpander::Client.expand("http://dld.bz/ahsJ2")
    #
    class Dldbz < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      PATTERN = %r'(http://dld\.bz/([\w/]+))'
      
      attr_reader :parent_klass, :short_url
      
      def initialize(short_url, options={})
        @parent_klass = self
        @short_url = short_url
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'dld.bz'
        format :json
      end
      
      
      private
      
      def fetch_url
        data = JSON.parse Request.get("/api/expand?url=#{@short_url}").response.body
        if(data.include?("data"))
          @long_url = data["data"]["long_url"]
        else
          error = data["error"]
          raise UrlExpander::Error.new(error["message"],error["code"])
        end
      end
    end
  end
end