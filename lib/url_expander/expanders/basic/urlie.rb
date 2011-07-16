module UrlExpander
  module Expanders
    #
    # Expand url.ie URLS
    # Usage:
    # UrlExpander::Client.expand("http://url.ie/cert")
    #
    class Urlie < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://url\.ie(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://url.ie'
      end
    end
  end
end