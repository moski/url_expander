module UrlExpander
  module Expanders
    #
    # Expand nutshellurl.com URLS
    # Usage:
    # client = UrlExpander::Client.new
    # client.expand("http://nutshellurl.com/1v38")
    #
    class Nutshellurl < UrlExpander::Expanders::Basic
      PATTERN = %r'(http://nutshellurl\.com/([\w/]+))'
      attr_reader :parent_klass
      
      def initialize(short_url="", options={})
        @parent_klass = self
        super(short_url, options)
      end
      
      # Custom fetcher.
      def fetch_url(path)
        url = super("/nutshells/nut#{path}.php")
        raise UrlExpander::Error.new('page not found',404) if url == "http://nutshellurl.com/notfound.php"
        url
      end
      
      class Request
        include HTTParty
        base_uri 'http://nutshellurl.com'
      end
    end
  end
end