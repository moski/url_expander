module UrlExpander
  module Expanders
    #
    # Expand Bitly URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://bit.ly/k3irb0+", :login => 'moski', :api_key => 'XXXXXXXX')
    #
    class Bitly < UrlExpander::Expanders::API
      # NOTICE: We ignored the / before the key
      # http://bit.ly/k3irb0+ => 'k3irb0+' without /
      PATTERN = %r'(http://bit\.ly/([\w/]+))'
      
      attr_reader :parent_klass
      attr_accessor :login, :api_key
      
      def initialize(short_url, options={})
        @parent_klass = self.class
        @login   = options[:login] if options[:login]
        @api_key = options[:api_key] if options[:api_key]
        
        if @login.nil? || @api_key.nil?
          raise ArgumentError.new('Bitly Expander require login, api_key. http://code.google.com/p/bitly-api/wiki/ApiDocumentation#/v3/expand')
        end
        
        super(short_url,options)
        fetch_url
      end
      
      class Request
        include HTTParty
        base_uri 'api.bit.ly'
        format :json
      end
      
      private
      
      def fetch_url
        data = JSON.parse Request.get("/v3/expand?hash=#{@shortner_key}&login=#{@login}&apiKey=#{@api_key}").response.body
        expand = data['data']['expand'].first
        if(data['status_code'] == 200 && !expand.has_key?('error'))
          @long_url = expand["long_url"]
        else
          raise UrlExpander::Error.new(expand['error'],data['status_code'])
        end
      end
    end
  end
end