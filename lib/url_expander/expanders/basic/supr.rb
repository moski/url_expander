module UrlExpander
  module Expanders
    #
    # Expand su.pr URLS
    # Usage:
    # UrlExpander::Client.expand("http://su.pr/Ad5dk1")
    #
    class Supr < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://su\.pr(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://su.pr'
      end
    end
  end
end