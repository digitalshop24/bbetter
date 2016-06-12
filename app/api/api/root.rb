require 'grape-swagger'
module API
  class Root < Grape::API
    content_type :json, "application/json;charset=UTF-8"
    prefix 'api'
    mount API::V1::Root 
  end
end
