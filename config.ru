require_relative 'backend/app/application' unless __FILE__ == '(eval)'

use Rack::Static, :urls => { "/" => "index.html" }, :root => "public", :index => 'index.html'

base_url = ENV['BASE_URL'] || 'http://localhost:5000'
RestfulObjects::DomainModel.current.base_url = "#{base_url}/restful_objects"

run Rack::URLMap.new({ '/' => Rack::File.new('public'), '/restful_objects' => RestfulObjects::Router::Base.new })

