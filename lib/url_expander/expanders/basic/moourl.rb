module UrlExpander
  module Expanders
    #
    # Expand moourl.com URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://moourl.com/flsho")
    #
    class Moourl < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://moourl\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      def fetch_url(path)
        url = super(path)
        raise UrlExpander::Error.new('page not found',404) if url == '/404/'
        url
      end
      
      class Request
        include HTTParty
        base_uri 'http://moourl.com'
      end
    end
  end
end