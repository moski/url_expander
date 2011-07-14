module UrlExpander
  module Expanders
    class API
      attr_accessor :long_url
      attr_reader   :parttern, :parent_klass, :shortner_key

      # Called from the Subclasses, its only job to set the @shortner_key
      # For example, if the short_url = 'http://bit.ly/k3irb0+'
      # then @shortner_key = 'k3irb0+'
      def initialize(short_url="", options={})
        if short_url.match(parent_klass::PATTERN)
          @shortner_key = $2
        else
          raise 'invalid pattern'
        end
      end
    end
  end
end