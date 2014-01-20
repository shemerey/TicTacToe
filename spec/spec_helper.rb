require 'rubygems'
require 'simplecov'
require 'tic_tac_toe'
require 'cadre/rspec'
require 'cadre/simplecov'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.add_formatter(Cadre::RSpec::TrueFeelingsFormatter) if config.formatters.empty?
  config.add_formatter(Cadre::RSpec::NotifyOnCompleteFormatter)
  config.add_formatter(Cadre::RSpec::QuickfixFormatter)
end

SimpleCov.start do
  formatter Cadre::SimpleCov::VimFormatter
end
