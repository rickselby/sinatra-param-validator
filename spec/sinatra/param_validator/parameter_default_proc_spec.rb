# frozen_string_literal: true

require "sinatra/test_helpers"

describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers

  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :date, Date, default: -> { Date.today }
      end

      post "/", validate: :identifier do
        params.to_json
      end
    end
  end

  it "does not change the value if one is passed" do
    post "/", { date: "2022-06-01" }
    expect(last_response.body).to eq({ date: "2022-06-01" }.to_json)
  end

  it "does change the value if nothing is passed" do
    post "/"
    expect(last_response.body).to eq({ date: Date.today }.to_json)
  end

  it "does change the value if only the key is passed" do
    post "/", { date: nil }
    expect(last_response.body).to eq({ date: Date.today }.to_json)
  end
end
