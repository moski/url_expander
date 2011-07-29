module UrlExpander
  module Expanders
    #
    # Expand tnw.to URLS
    # Usage:
    # UrlExpander::Client.expand("http://tnw.to/1A3qT")
    #
    class Tnwto < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://tnw\.to(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://tnw.to'
      end
    end
  end
end