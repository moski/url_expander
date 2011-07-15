module UrlExpander
  module Expanders
    #
    # Expand shrt.st URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://qsr.li/5Zg9")
    #
    class Qsrli < UrlExpander::Expanders::Scrape
      PATTERN = %r'(http://qsr\.li(/[\w/]+))'
      attr_reader :parent_klass, :xpath
      
      def initialize(short_url="", options={})
        @parent_klass = self.class
        super(short_url, options)
      end
      
      
      # How to scarpe the url from a Qsr.li html document
      def self.scrape_url(html)
        doc = Hpricot(html)
        doc.at('//*[@id="framecontent"]').attributes["src"]
      end
      
      class Request
        include HTTParty
        base_uri 'http://qsr.li'
      end
    end
  end
end