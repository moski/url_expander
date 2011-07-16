module UrlExpander
  module Expanders
    #
    # Expand shrt.st URLS
    # Usage:
    # UrlExpander::Client.expand("http://shrt.st/148u")
    #
    class Shrtst < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://shrt\.st(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://shrt.st'
      end
    end
  end
end