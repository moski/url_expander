module UrlExpander
  module Expanders
    #
    # Expand amzn shortner 
    # Usage:
    # UrlExpander::Client.expand("http://amzn.to/nHkw5A")
    #
    class Amzn < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://amzn\.(?:[\w/]+)/([\w/]+))'
    end
  end
end