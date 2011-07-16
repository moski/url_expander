module UrlExpander
  module Expanders
    #
    # Expand techcruch
    # Usage:
    # UrlExpander::Client.expand("http://tcrn.ch/oe50JN")
    #
    class Tcrnch < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://tcrn\.ch/([\w/]+))'
    end
  end
end