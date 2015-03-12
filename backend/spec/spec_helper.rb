require 'rack/test'
require 'json_expressions/rspec'
require_relative '../app/application'

module Helpers
  def app
    RestfulObjects::Router::Base
  end
end

RSpec::configure do |config|
  config.include Helpers
  config.include Rack::Test::Methods
end

RestfulObjects::Router::Base.set :show_exceptions, false
RestfulObjects::Router::Base.set :raise_errors,    true

JsonExpressions::Matcher.assume_strict_arrays = false
JsonExpressions::Matcher.assume_strict_hashes = false

module JsonExpressions
  module RSpec
    module Matchers
      class MatchJsonExpression
        def failure_message
          "expected:\n#{JSON.pretty_generate @target}\n to match JSON expression:\n#{@expected.inspect}\n\n" + @expected.last_error
        end

        def failure_message_when_negated
          "expected:\n#{JSON.pretty_generate @target}\n not to match JSON expression:\n#{@expected.inspect}\n"
        end

        def description
          "should equal JSON expression:\n#{@expected.inspect}\n"
        end
      end
    end
  end
end
