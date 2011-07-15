module UrlExpander
  module Expanders
    #
    # Expand Youtu.be URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://youtu.be/bINUfbLV_0M")
    # client.expand("http://y2u.be/bINUfbLV_0M")
    #
    class Youtube < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://(?:youtu\.be|y2u\.be)(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://youtu.be'
      end
    end
  end
end