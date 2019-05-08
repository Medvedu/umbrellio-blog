module Types
  include Dry::Types.module
end

module Api
  module V1
    class Post < ROM::Struct
      constructor_type(:schema)

      attribute :title, Types::Strict::String
      attribute :body, Types::Strict::String

      attribute :author_ip, Types::Coercible::String
      attribute :author_id, Types::Strict::Int

      # @return [Hash]
      def viewable
        {
          title: title,
          body: body,
          # author_ip: author_ip.to_s,
          # author_id: author_id
        }
      end
    end
  end
end
