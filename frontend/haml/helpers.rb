def render(partial)
  Haml::Engine.new(File.read("frontend/haml/partials/#{partial}.haml")).render
end

