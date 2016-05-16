require 'grape-swagger'
module API
  class Root < Grape::API
    prefix 'api'
    mount API::V1::Root
    add_swagger_documentation(
      base_path: "",
      api_version: "v1",
      hide_documentation_path: true
    )

    rescue_from :all, backtrace: true
    error_formatter :json, API::ErrorFormatter
  end
end
