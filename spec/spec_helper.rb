require 'restful_objects'
require 'rspec'
require 'capybara/rspec'

require_relative '../backend/app/application'

CONFIG_RU = File.read(File.expand_path(File.join('..', 'config.ru'), File.dirname(__FILE__)))
Capybara.app = eval("Rack::Builder.new { " + CONFIG_RU + "\n }")
Capybara.javascript_driver = :selenium
Capybara.default_wait_time = 4
Capybara.server_port = 12345

RestfulObjects::DomainModel.current.base_url = "http://localhost:12345/restful_objects"

module SpecHelpers
  def app
    Application.instance
  end

  def fragment(url)
    /.*(#.*)/.match(url)[1]
  end
end

RSpec.configure do |config|
  config.include SpecHelpers

  config.after :each do
    Application.instance.reset
  end
end

