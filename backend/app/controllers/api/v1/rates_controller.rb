module Api
  module V1
    class RatesController < ApplicationController
      # POST /api/v1/rates
      def create
        transaction = CreateRateTransaction.new
        transaction.call(rate_params) do |result|
          result.success do |rate|
            render json: { rate: rate }, status: :ok
          end

          result.failure :validate do |errors|
            render json: { errors: errors }, status: :unprocessable_entity
          end
        end
      end

      private

      # @return [Hash]
      def rate_params
        params.permit(:rate, :post_id).to_h.deep_symbolize_keys
      end
    end
  end
end
