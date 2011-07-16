module UrlExpander
  module Expanders
    #
    # Expand Foxnews
    # Usage:
    # UrlExpander::Client.expand("http://fxn.ws/pBewvL")
    #
    class Fxnws < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://fxn\.ws/([\w/]+))'
    end
  end
end