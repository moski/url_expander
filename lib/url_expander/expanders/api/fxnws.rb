module UrlExpander
  module Expanders
    #
    # Expand Foxnews
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://fxn.ws/pBewvL", :login => 'moski', :api_key => 'XXXXXXXX')
    #
    class Fxnws < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://fxn\.ws/([\w/]+))'
    end
  end
end