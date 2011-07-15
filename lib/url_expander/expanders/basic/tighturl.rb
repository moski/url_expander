module UrlExpander
  module Expanders
    #
    # Expand Tighturl URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://tighturl.com/3eoz")
    #
    class Tighturl < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://tighturl\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://tighturl.com'
      end
    end
  end
end