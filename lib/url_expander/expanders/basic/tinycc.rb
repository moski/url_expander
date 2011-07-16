module UrlExpander
  module Expanders
    #
    # Expand tiny.cc URLS
    # Usage:
    # UrlExpander::Client.expand("http://tiny.cc/pabx5")
    #
    class Tinycc < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://tiny\.cc(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      def fetch_url(path)
        url = super(path)
        raise UrlExpander::Error.new('page not found',404) if url == 'http://tiny.cc/notfound'
        url
      end
      
      class Request
        include HTTParty
        base_uri 'tiny.cc'
      end
    end
  end
end