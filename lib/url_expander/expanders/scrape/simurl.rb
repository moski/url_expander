module UrlExpander
  module Expanders
    #
    # Expand http://simurl.com/ URLS
    # Usage:
    # UrlExpander::Client.expand("http://simurl.com/fendaz")
    #
    class Simurl < UrlExpander::Expanders::Scrape
      PATTERN = %r'(http://simurl\.com(/[\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      # How to scarpe the url from a Qsr.li html document
      def self.scrape_url(html)
        doc = Hpricot(html)
        str = doc.at("meta").attributes['content']
        start_slice = str.index("=") +1
        end_slice   = str.size - start_slice 
        url = str.slice(start_slice, end_slice)
        raise UrlExpander::Error.new('page not found',404) if url == "/index.php"
        url
      end
      
      class Request
        include HTTParty
        base_uri 'http://simurl.com'
      end
    end
  end
end