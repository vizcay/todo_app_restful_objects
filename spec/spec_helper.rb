require 'restful_objects'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
require 'json_expressions/rspec'
require_relative 'support/helpers'
require_relative 'support/json_expressions'
require_relative '../backend/app/application'

CONFIG_RU = File.read(File.expand_path(File.join('..', 'config.ru'), File.dirname(__FILE__)))
Capybara.app = eval("Rack::Builder.new { " + CONFIG_RU + "\n }")
Capybara.javascript_driver = :selenium
Capybara.default_wait_time = 4
Capybara.server_port = 12345

RestfulObjects::DomainModel.current.base_url = "http://localhost:12345/restful_objects"

RSpec.configure do |config|
  config.include SpecHelpers
  config.include Rack::Test::Methods

  config.after :each do
    Application.instance.reset
  end
end

RestfulObjects::Router::Base.set :show_exceptions, false
RestfulObjects::Router::Base.set :raise_errors,    true

JsonExpressions::Matcher.assume_strict_arrays = false
JsonExpressions::Matcher.assume_strict_hashes = false
