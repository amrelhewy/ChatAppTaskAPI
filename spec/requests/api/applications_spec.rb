require "swagger_helper"

RSpec.describe "api/v1/applications_controller", type: :request do
  path "/api/v1/applications" do
    post "Create an application" do
      tags "Applications"
      consumes "application/json"
      parameter name: :application, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          token: { type: :text },
        },
        required: ["name"],
      }
      response "201", "application created" do
        let(:application) { { name: "Application#1" } }
        run_test!
      end
      response "422", "invalid request" do
        let(:application) { { name: "Application#1" } }
        run_test!
      end
    end
  end
end
