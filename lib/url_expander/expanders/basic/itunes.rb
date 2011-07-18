module UrlExpander
  module Expanders
    #
    # Expand itun.es URLS
    # Usage:
    # UrlExpander::Client.expand("http://itun.es/igG8XL")
    #
    class Itunes < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://itun\.es(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://itun.es'
      end
    end
  end
end