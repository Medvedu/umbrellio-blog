require 'dry-transaction'

module Api
  module V1
    class CreatePostTransaction
      include Dry::Transaction

      step :validate
      step :create

      def validate(input)
        validation = PostSchema.(input)

        if validation.success?
          Success(input)
        else
          Failure(validation.errors)
        end
      end

      def create(input)
        result = repository.create_with_user(input)

        Success(result)
      end

      private

      # @return [Api::V1::PostRepository]
      def repository
        PostRepository.new(ROM.env)
      end
    end
  end
end
