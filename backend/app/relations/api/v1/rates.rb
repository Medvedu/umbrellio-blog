module Api
  module V1
    class Rates < ROM::Relation[:sql]
      schema(:rates, infer: true) do
        associations do
          belongs_to :post
          # belongs_to :user
        end
      end
    end
  end
end
