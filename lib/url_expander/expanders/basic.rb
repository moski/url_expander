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
        if short_url.match(parent_klass.class::PATTERN)
          @long_url = parent_klass.fetch_url($2)
        else
          raise 'invalid pattern'
        end
      end
      
      protected
      
      # Common fetcher used my most expanders.
      def fetch_url(path)
        url = nil
        result = parent_klass.class::Request.head(path, :follow_redirects => false)
        case result.response
          when Net::HTTPMovedPermanently
            url = result['Location']
          when Net::HTTPFound
            url = result['location']
        end
        
        raise UrlExpander::Error.new('page not found',404) if url.nil?
        url
      end
    end
  end
end