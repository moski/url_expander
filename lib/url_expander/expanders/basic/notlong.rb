module UrlExpander
  module Expanders
    #
    # Expand notlong.com URLS
    # Usage:
    # UrlExpander::Client.expand("http://moski.notlong.com")
    #
    class Notlong < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://([\w/]+)\.notlong\.com)'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      # Custom fetcher.
      def fetch_url(path)
        super("/#{path}")
      end
      
      
      class Request
        include HTTParty
        base_uri 'notlong.com'
      end
    end
  end
end