module UrlExpander
  module Expanders
    #
    # Expand t11.me URLS
    # Usage:
    # UrlExpander::Client.expand("http://t11.me/YZI-Y6")
    #
    class T11me < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://t11\.me(/[\w-/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      def fetch_url(path)
        super("/shortlink#{path}")
      end
      
      class Request
        include HTTParty
        base_uri 'http://tap11.com'
      end
      
    end
  end
end