require 'dry-transaction'

module Api
  module V1
    class CreateRateTransaction
      include Dry::Transaction

      step :validate
      step :create

      def validate(input)
        validation = RateSchema.(input)

        if validation.success?
          Success(input)
        else
          Failure(validation.errors)
        end
      end

      def create(input)
        result = repository.create(input)

        Success(result)
      end

      private

      # @return [Api::V1::RateRepository]
      def repository
        RateRepository.new(ROM.env)
      end
    end
  end
end
