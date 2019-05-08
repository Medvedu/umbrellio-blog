module Api
  module V1
    class Users < ROM::Relation[:sql]
      schema(:users, infer: true) do
        associations do
          has_many :posts
          # has_many :rates
        end
      end
    end
  end
end
