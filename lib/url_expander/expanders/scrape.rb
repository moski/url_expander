require 'Hpricot'

module UrlExpander
  module Expanders
    
    # Some websites don't follow the coding standards. They don't provide an
    # api and they don't provide 301 redirect. The only way to get the shorten
    # url is by parsing the returned html doc.
    # 
    # To use the Scrape class, define your class inside scrape folder. Your class must 
    # provide the following:
    #   def initialize(short_url="", options={})
    #   def self.scrape_url(html)
    #   class Request
    #
    # Example:
    # class Qsrli < UrlExpander::Expanders::Scrape
    #   PATTERN = %r'(http://qsr\.li(/[\w/]+))'
    #   attr_reader :parent_klass, :xpath
    # 
    #   def initialize(short_url="", options={})
    #     @parent_klass = self.class
    #     super(short_url, options)
    #   end
    # 
    #   def self.scrape_url(html)
    #     doc = Hpricot(html)
    #     doc.at('//*[@id="framecontent"]').attributes["src"]
    #   end
    # 
    #   class Request
    #     include HTTParty
    #     base_uri 'http://qsr.li'
    #   end
    # end
    class Scrape
      attr_accessor :long_url
      attr_reader   :parttern, :parent_klass
      
      def initialize(short_url="",options={})
        if short_url.match(parent_klass::PATTERN)
          path = $2
        else
          raise 'invalid pattern'
        end
        
        @long_url = fetch_url(path)
      end
      
      
      protected
      
      def fetch_url(path)
        url = nil
        result = parent_klass::Request.get(path, :follow_redirects => false)
        case result.response
          when Net::HTTPMovedPermanently
            url = result['Location']
          when Net::HTTPFound
            url = result['location']
          when Net::HTTPOK
            url = parent_klass.scrape_url(result.response.body)
        end
        
        raise UrlExpander::Error.new('page not found',404) if url.nil?
        url
      end
      
    end
  end
end