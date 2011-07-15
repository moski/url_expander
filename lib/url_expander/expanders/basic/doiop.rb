module UrlExpander
  module Expanders
    #
    # Expand doiop.com URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://doiop.com/dz8896")
    #
    class Doiop < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://doiop\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      # Custom fetcher.
      def fetch_url(path)
        url = super(path)
        raise UrlExpander::Error.new('page not found',404) if url == "http://doiop.com/?error=404"
        url
      end
      
      class Request
        include HTTParty
        base_uri 'http://doiop.com'
      end
    end
  end
end