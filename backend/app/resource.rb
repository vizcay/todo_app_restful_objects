require 'restful_objects'

class Resource
  include RestfulObjects::Object

  property :description, :string, max_length: 50
  property :cost,        :decimal
end
