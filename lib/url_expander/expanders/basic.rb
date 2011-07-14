require 'json'

module UrlExpander
  module Expanders
    
    #
    # This is the basic class for all simple Net::HTTPMovedPermanently
    # Each subclass must define a url Pattern and a Reqest class for httpartty.
    # Ex:
    # module UrlExpander
    #  module Expanders
    #    class Tinyurl < UrlExpander::Expanders::Basic
    #      class Request
    #        include HTTParty
    #        base_uri 'http://tinyurl.com'
    #      end
    #
    #      PATTERN = %r'(http://tinyurl\.com(/[\w/]+))'
    #      attr_reader :parent_klass
    #
    #      def initialize(short_url="",options={})
    #        @parent_klass = self.class
    #        super(shot_url,options)
    #      end
    #    end
    #  end
    # end
    #
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://tinyurl.com/asdf")
    #
    class Basic
      attr_accessor :long_url
      attr_reader   :parttern, :parent_klass
      
      
      def initialize(short_url="",options={})
        if short_url.match(parent_klass::PATTERN)
          @long_url = fetch_url($2)
        else
          raise 'invalid pattern'
        end
      end
      
      private
      
      def fetch_url(path)
        result = parent_klass::Request.head(path, :follow_redirects => false)
        case result.response
          when Net::HTTPMovedPermanently
            result['Location']
          when Net::HTTPFound
            result['location']
        end
      end
    end
  end
end