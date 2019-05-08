require 'rails_helper'

RSpec.describe 'Api::V1::RatesController', type: :request do
  # Api::V1::RatesController#create
  # POST /api/v1/rates
  context '#create' do
    let :headers do
      { 'Content-Type' => 'application/json' }
    end

    it 'returns code 200' do
      params = {
        rate: 1, post_id: 1
      }.to_json

      post '/api/v1/rates', params: params, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
    end

    it 'returns code 402' do
      params = {
        rate: -1.0, post_id: 1
      }.to_json

      post '/api/v1/posts', params: params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq('application/json')
    end
  end
end
