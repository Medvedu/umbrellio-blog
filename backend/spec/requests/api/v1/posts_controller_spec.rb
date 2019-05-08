require 'rails_helper'

RSpec.describe 'Api::V1::PostsController', type: :request do
  # Api::V1::PostsController#create
  # POST /api/v1/posts
  context '#create' do
    let(:repository) { double(:repository) }

    let :headers do
      { 'Content-Type' => 'application/json' }
    end

    before do
      allow_any_instance_of(Api::V1::CreatePostTransaction)
        .to receive(:repository).and_return(repository)
    end

    it 'returns code 200' do
      params = {
        title: 'title', body: 'body', author_login: 'login'
      }.to_json
      post = double(:post)

      expect(repository)
        .to receive(:create_with_user).and_return(post)

      post '/api/v1/posts', params: params, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
    end

    it 'returns code 402' do
      params = {
        title: 'title', body: 'body', author_login: ''
      }.to_json

      post '/api/v1/posts', params: params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq('application/json')
    end
  end

  # Api::V1::PostsController#top_by_avg_rate
  # GET /api/v1/posts/top_by_avg_rate
  context '#top_by_avg_rate' do
    xit '' do
    end
  end

  # Api::V1::PostsController#find_authors_with_same_ip
  # GET /api/v1/posts/find_authors_with_same_ip
  context '#find_authors_with_same_ip' do
    xit '' do
    end
  end
end
