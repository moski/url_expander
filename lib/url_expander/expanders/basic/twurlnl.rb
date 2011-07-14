module UrlExpander
  module Expanders
    class Twurlnl < UrlExpander::Expanders::Basic
      
      PATTERN = %r'(http://twurl\.nl(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="",options={})
        @parent_klass = self.class
        super(shot_url,options)
      end
      
      class Request
        include HTTParty
        base_uri 'http://twurl.nl'
      end
      
    end
  end
end