require 'rubygems'
require 'simplecov'
require 'tic_tac_toe'
require 'cadre/rspec'
require 'cadre/simplecov'

# Requires supporting files with custom matchers and macros, etc, in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.add_formatter(Cadre::RSpec::TrueFeelingsFormatter) if config.formatters.empty?
  config.add_formatter(Cadre::RSpec::NotifyOnCompleteFormatter)
  config.add_formatter(Cadre::RSpec::QuickfixFormatter)
end

SimpleCov.start do
  formatter Cadre::SimpleCov::VimFormatter
end
