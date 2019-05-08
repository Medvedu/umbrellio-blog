require 'dry-validation'

module Api
  module V1
    RateSchema = Dry::Validation.Schema do
      configure do
        config.messages_file = Rails.root.join(
          'config', 'locales', 'schemas', 'en.yml'
        )

        config.namespace = :rate

        # @param [Integer] post_id
        def post_exist?(post_id)
          PostRepository.new(ROM.env).exist?(post_id)
        end
      end

      required(:rate).filled(:int?, gteq?: 1, lteq?: 5)
      required(:post_id).filled(:int?, :post_exist?)
    end
  end
end
