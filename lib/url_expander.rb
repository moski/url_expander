require 'rubygems'
require 'httparty'

$:.unshift(File.dirname(__FILE__))

require 'url_expander/expanders/expanders'

module UrlExpander
  class Client
    # Expand a given url.
    def self.expand(url="",options = {})
      
      # Setup the default options
      options[:nested_shortening] = true unless options.has_key?(:nested_shortening)
      if options[:nested_shortening]
        options[:limit] = 10 unless options.has_key?(:limit)
      end
      options[:config_file] = "#{ENV['HOME']}/url_expander_credentials.yml" unless options[:config_file]
      
      # We Reached the maximum number of redirections, quit.
      raise ArgumentError, 'HTTP redirect too deep' if options[:nested_shortening] && options[:limit] == 0
      
      # Make sure we have a url
      raise ArgumentError.new('Expander requires a short url') if url.nil? || url.empty?
      exclude_klasses = ['UrlExpander::Expanders::Basic', 'UrlExpander::Expanders::API', 'UrlExpander::Expanders::Scrape']
      
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
      @expander = (!expander_klass.nil?) ? expander_klass.new(url,options) : nil
      
      if @expander.nil? && !options[:is_redirection]
        raise ArgumentError.new('Unknow url') 
      end
      
      if options[:nested_shortening] & !@expander.nil?
        options[:limit] -= 1
        options[:is_redirection] = true
        UrlExpander::Client.expand(@expander.long_url, options)
      else
        (@expander.nil?) ? url : @expander.long_url
      end
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