module UrlExpander
  module Expanders
    #
    # Expand ur1.ca URLS
    # Usage:
    # UrlExpander::Client.expand("http://ur1.ca/4qcly")
    #
    class Ur1ca < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://ur1\.ca(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://ur1.ca'
      end
    end
  end
end