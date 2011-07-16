module UrlExpander
  module Expanders
    #
    # Expand 4sqr shortner 
    # Usage:
    # UrlExpander::Client.expand("http://4sq.com/pQkuZk")
    #
    class Foursq < UrlExpander::Expanders::Bitly
      PATTERN = %r'(http://4sq\.com/([\w/]+))'
    end
  end
end