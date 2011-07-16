module UrlExpander
  module Expanders
    #
    # Expand Adjix URLS
    # Usage:
    # UrlExpander::Client.expand("http://adjix.com/cm4m")
    #
    class Adjix < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://(?:adjix\.com|ad\.vu)(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      def fetch_url(path)
        url = super(path)
        raise UrlExpander::Error.new('page not found',404) if url == 'http://www.adjix.com/notfound.html'
        url
      end
      
      class Request
        include HTTParty
        base_uri 'http://adjix.com'
      end
    end
  end
end