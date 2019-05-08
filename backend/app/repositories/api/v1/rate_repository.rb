require 'rom-repository'

module Api
  module V1
    class RateRepository < ROM::Repository[:rates]
      # @return [Float]
      def create(input)
        rates.transaction(isolation: :serializable) do
          rate = rates.command(:create).call(input)

          post = posts.by_pk(rate.post_id)
          rom_post = post.one

          upd_post = post.command(:update).call(
            rate_sum: rom_post.rate_sum + rate.rate,
            rate_count: rom_post.rate_count + 1
          )

          (upd_post.rate_sum / upd_post.rate_count).round(4)
        end
      end
    end
  end
end
