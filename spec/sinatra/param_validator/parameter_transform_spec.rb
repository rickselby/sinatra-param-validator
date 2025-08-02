# frozen_string_literal: true

require "sinatra/test_helpers"

describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers

  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :time, Time, transform: ->(v) { v.strftime("%H:%M") }
      end

      post "/", validate: :identifier do
        params.to_json
      end
    end
  end

  it "transforms the value if the parameter is valid" do
    post "/", { time: "2022-07-19 12:59:00" }
    expect(last_response.body).to eq({ time: "12:59" }.to_json)
  end

  it "does not transform the value if the parameter is invalid" do
    expect { post "/", { time: "foo" } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end

  it "does not try to transform the value if the parameter is missing" do
    post "/"
    expect(last_response.body).to eq({}.to_json)
  end

  it "does not try to transform the value if the parameter is empty" do
    post "/", { time: nil }
    expect(last_response.body).to eq({ time: nil }.to_json)
  end
end
