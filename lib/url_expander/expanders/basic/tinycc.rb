module UrlExpander
  module Expanders
    #
    # Expand tiny.cc URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://tiny.cc/pabx5")
    #
    class Tinycc < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://tiny\.cc(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'tiny.cc'
      end
    end
  end
end