$:.unshift(File.dirname(__FILE__))

require 'bitly/domains'
require 'digest/md5'

module UrlExpander
  module Expanders
    #
    # Expand Bitly URLS
    # Usage:
    # UrlExpander::Client.expand("http://bit.ly/qpshuI")
    # UrlExpander::Client.expand("http://j.mp/qpshuI")
    # UrlExpander::Client.expand("http://nyti.ms/dzy2b7")
    # UrlExpander::Client.expand("http://tcrn.ch/oe50JN")
    # UrlExpander::Client.expand("http://fxn.ws/pBewvL") 
    #
    class Bitly < UrlExpander::Expanders::API
      # Note: Don't use this for a global matching, it will match all
      # urls. Instead we have a custom matching function def self.is_me?(url)
      PATTERN = %r'(?:https?://){1}([^/]*)/([\w/]+)'
      
      attr_reader :parent_klass
      attr_accessor :login, :api_key
      
      def initialize(short_url, options={})
        @parent_klass = self
        load_credentials(options[:config_file])
        
        if @login.nil? || @api_key.nil?
          raise ArgumentError.new('Bitly Expander require login, api_key. Run "rake url_expander:generate_config"')
        end
        
        super(short_url,options)
        fetch_url
      end
      
      # A custom pattern matching function
      def self.is_me?(url)
        if url.match(PATTERN)
          domain_digest = Digest::MD5.hexdigest($1)
          DOMAINS.include?(domain_digest)
        else
          false
        end
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
      
      def load_credentials(file_path)
        unless File.exists?(file_path)
          raise ArgumentError.new('Bitly Expander require login, api_key. Run "rake url_expander:generate_config"')
        else
          credentials = YAML.load_file(file_path)[:bitly]
          @login   = credentials[:login]
          @api_key = credentials[:api_key]
        end
      end
    end
  end
end