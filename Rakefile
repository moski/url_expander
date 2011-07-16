# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "url_expander"
  gem.homepage = "http://github.com/moski/url_expander"
  gem.license = "MIT"
  gem.summary = %Q{Expand short url from different services}
  gem.description = %Q{Expand short urls from shortning services shuch as bitly and tinyurl}
  gem.email = "abushaikh@gmail.com"
  gem.authors = ["Moski"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "url_expander #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


namespace :url_expander do
  desc "Generate config file"
  task(:generate_config) do
    credentials = {
        :bitly => {
          :login   => 'BITLY LOGIN',
          :api_key => 'BITLY API KEY' 
        }
      }
    File.open('url_expander_credentials.yml', 'w') { |file| YAML.dump(credentials, file) }
  end
end



