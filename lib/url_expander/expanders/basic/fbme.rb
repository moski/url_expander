module UrlExpander
  module Expanders
    #
    # Expand fb.me URLS
    # Usage:
    # UrlExpander::Client.expand("http://fb.me/KLfffqy3")
    #
    class Fbme < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://fb\.me(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://fb.me'
      end
    end
  end
end