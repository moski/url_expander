module UrlExpander
  module Expanders
    #
    # Expand Newyork times
    # Usage:
    # UrlExpander::Client.expand("http://nyti.ms/dzy2b7")
    #
    class Nytims < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://nyti\.ms/([\w/]+))'
    end
  end
end