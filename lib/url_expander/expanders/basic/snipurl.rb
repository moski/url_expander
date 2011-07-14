module UrlExpander
  module Expanders
    #
    # Expand snipurl.com URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://snipurl.com/209hem")
    # client.expand("http://sn.im/209hem") 
    #
    # @NOTE: This service does provide an api but it is not working
    #            
    class Snipurl < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://(?:snipurl\.com|sn\.im|cl\.lk|snipr\.com|snurl\.com)(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://snipurl.com'
      end
    end
  end
end