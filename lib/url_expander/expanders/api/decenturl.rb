module UrlExpander
  module Expanders
    
    #
    # Expand Budurl URLS
    # Usage:
    # UrlExpander::Client.expand("http://decenturl.com/youtube/medieval")
    # UrlExpander::Client.expand("http://youtube.decenturl.com/medieval")
    #
    class Decenturl < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://decenturl.com/youtube/medieval => 'youtube/medieval' without /
      PATTERN = %r'(http://(?:(?>[a-z0-9-]*\.)+?|)decenturl\.com/([\w/]+))'
      
      attr_reader :parent_klass, :short_url
      
      def initialize(short_url, options={})
        @parent_klass = self
        @short_url = short_url
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'decenturl.com'
        format :json
      end
      
      
      private
      
      def fetch_url
        data = JSON.parse Request.get("/api-resolve?d=#{@short_url}").response.body
        if(data.include?("ok"))
          @long_url = data[1]
        else
          raise UrlExpander::Error.new(data.join(","),404)
        end
      end
    end
  end
end