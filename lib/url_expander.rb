require 'rubygems'
require 'httparty'

$:.unshift(File.dirname(__FILE__))

require 'url_expander/expanders/expanders'

module UrlExpander
  class Client
    attr_reader :long_url, :short_url, :expander
    
    # Creation of a new client.
    def initialize
      @short_url = @long_url = nil 
    end
    
    # Expand a given url.
    def expand(url="",options = {})
      raise ArgumentError.new('Expander requires a short url') if url.nil? || url.empty?
      
      exclude_klasses = ['UrlExpander::Expanders::Basic', 'UrlExpander::Expanders::API']
      
      # Get the names for all the expanders except the basic default one.
      mod     = UrlExpander::Expanders
      expanders = mod.constants.collect{|c| mod.const_get(c)}.select{|c| c.class == Class && !exclude_klasses.include?(c.to_s)}
      expander_klass = nil
      
      # Find the correct expander
      expanders.each do |exp|
        if(exp::PATTERN.match(url))
          expander_klass = exp
        end
      end
      @expander = (!expander_klass.nil?) ? expander_klass.new(url,options) : UrlExpander::Expanders::Basic.new(url)
      @long_url = @expander.long_url
    end
  end
  
  class Error < StandardError
    attr_reader :code
    alias :msg :message
    def initialize(msg, code)
      @code = code
      super("#{msg} - '#{code}'")
    end
  end
end