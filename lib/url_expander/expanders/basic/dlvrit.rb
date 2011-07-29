module UrlExpander
  module Expanders
    #
    # Expand dlvr.it URLS
    # Usage:
    # UrlExpander::Client.expand("http://dlvr.it/ccG3g")
    #
    class Dlvrit < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://dlvr\.it(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://dlvr.it'
      end
    end
  end
end