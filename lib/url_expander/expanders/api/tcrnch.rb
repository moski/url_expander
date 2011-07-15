module UrlExpander
  module Expanders
    #
    # Expand techcruch
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://tcrn.ch/oe50JN", :login => 'moski', :api_key => 'XXXXXXXX')
    #
    class Tcrnch < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://tcrn\.ch/([\w/]+))'
    end
  end
end