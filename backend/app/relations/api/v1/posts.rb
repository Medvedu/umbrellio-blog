module Api
  module V1
    class Posts < ROM::Relation[:sql]
      schema(:posts, infer: true) do
        associations do
          belongs_to :user, as: :author

          has_many :rates
        end
      end
    end
  end
end
