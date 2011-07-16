module UrlExpander
  module Expanders
    #
    # Expand Twitter shortner t.co
    # Usage:
    # UrlExpander::Client.expand("http://t.co/ZGEGdas")
    #
    class Tco < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://t\.co(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://t.co'
      end
    end
  end
end