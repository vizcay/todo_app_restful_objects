module SpecHelpers
  def app
    RestfulObjects::Router::Base
  end

  def todo_app
    Application.instance
  end

  def fragment(url)
    /.*(#.*)/.match(url)[1]
  end
end
