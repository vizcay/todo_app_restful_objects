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
