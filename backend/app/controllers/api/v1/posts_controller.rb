module Api
  module V1
    class PostsController < ApplicationController
      # POST /api/v1/posts
      def create
        transaction = CreatePostTransaction.new
        transaction.(post_params.merge(author_ip: request.remote_ip)) do |result|
          result.success do |post|
            render json: { post: post }, status: :ok
          end

          result.failure :validate do |errors|
            render json: { errors: errors }, status: :unprocessable_entity
          end
        end
      end

      # GET /api/v1/posts/top_by_avg_rate
      def top_by_avg_rate
        render json: repository.get_top_posts_by_avg_rate, status: :ok
      end

      # GET /api/v1/posts/find_authors_with_same_ip
      def find_authors_with_same_ip
        render json: repository.find_authors_with_same_ip, status: :ok
      end

      private

      # @return [Hash]
      def post_params
        params.permit(:title, :body, :author_login).to_h.deep_symbolize_keys
      end

      # @return [Api::V1::PostRepository]
      def repository
        PostRepository.new(ROM.env)
      end
    end
  end
end
