module UrlExpander
  module Expanders
    #
    # Expand Newyork times
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://nyti.ms/dzy2b7", :login => 'moski', :api_key => 'XXXXXXXX')
    #
    class Nytims < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://nyti\.ms/([\w/]+))'
    end
  end
end