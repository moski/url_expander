module UrlExpander
  module Expanders
    #
    # Expand Adjix URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://adjix.com/cm4m")
    #
    class Adjix < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://(?:adjix\.com|ad\.vu)(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://adjix.com'
      end
    end
  end
end