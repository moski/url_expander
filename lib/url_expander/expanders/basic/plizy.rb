module UrlExpander
  module Expanders
    #
    # Expand plizy URLS
    # Usage:
    # UrlExpander::Client.expand("http://plizy.com/jzW29w")
    #
    class Plizy < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://plizy\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://plizy.com'
      end
    end
  end
end