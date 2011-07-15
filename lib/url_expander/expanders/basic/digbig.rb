module UrlExpander
  module Expanders
    #
    # Expand shrt.st URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://digbig.com/3bbd")
    #
    class Digbig < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://(?:(?>[a-z0-9-]*\.)+?|)digbig\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://www.digbig.com'
      end
    end
  end
end