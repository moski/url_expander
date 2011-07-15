$:.unshift(File.dirname(__FILE__))

require 'url_expander/expanders/basic'
require 'url_expander/expanders/api'
require 'url_expander/expanders/scrape'


module UrlExpander
  module Expanders
    autoload :Tinyurl, 'basic/tinyurl'
    autoload :Twurlnl, 'basic/twurlnl'
    autoload :Shrtst, 'basic/shrtst'
    autoload :Snipurl, 'basic/Snipurl'
    autoload :Adjix, 'basic/Adjix'
    autoload :Youtube, 'basic/Youtube'
    autoload :Tinycc, 'basic/Tinycc'
    autoload :Owly, 'basic/Owly'
    autoload :Digbig, 'basic/Digbig'
    autoload :Doiop, 'basic/Doiop'
    autoload :Easyurljp, 'basic/Easyurljp'
    autoload :Justas, 'basic/Justas'
    autoload :Moourl, 'basic/Moourl'
    autoload :Notlong, 'basic/Notlong'
    autoload :Nutshellurl, 'basic/Nutshellurl'
    
    
    # Using API
    autoload :Bitly, 'api/Bitly'
    autoload :Budurl, 'api/Budurl'
    autoload :Cligs, 'api/Cligs'
    autoload :Isgd, 'api/Isgd'
    autoload :Googl, 'api/Googl'
    autoload :Decenturl, 'api/Decenturl'
    autoload :Xrlus, 'api/Xrlus'
    
    
    # Using Scrapper
    autoload :Qsrli, 'scrape/Qsrli'
    autoload :Shorl, 'scrape/Shorl'
    autoload :Simurl, 'scrape/Simurl'
    
  end
end