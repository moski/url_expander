module UrlExpander
  module Expanders
    #
    # Expand Digbig URLS
    # Usage:
    # UrlExpander::Client.expand("http://digbig.com/3bbd")
    #
    class Digbig < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://(?:(?>[a-z0-9-]*\.)+?|)digbig\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      # Custom fetcher.
      def fetch_url(path)
        url = super(path)
        raise UrlExpander::Error.new('page not found',404) if url == "/error_404.html"
        url
      end
      
      class Request
        include HTTParty
        base_uri 'http://www.digbig.com'
      end
    end
  end
end