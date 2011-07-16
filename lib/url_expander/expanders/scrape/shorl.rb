module UrlExpander
  module Expanders
    #
    # Expand shorl.com URLS
    # Usage:
    # UrlExpander::Client.expand("http://shorl.com/nigekohalenu")
    #
    class Shorl < UrlExpander::Expanders::Scrape
      PATTERN = %r'(http://shorl\.com(/[\w/]+))'
      attr_reader :parent_klass, :xpath
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      
      # How to scarpe the url from a shorl html document
      def self.scrape_url(html)
        doc = Hpricot(html)
        doc.at('/html/body/div[3]/p/a').attributes["href"]
      end
      
      class Request
        include HTTParty
        base_uri 'http://shorl.com'
      end
    end
  end
end