module Api
  module V1
    class PostMapper < ROM::Mapper
      relation :Posts

      register_as :post

      model Api::V1::Post

      attribute :title
      attribute :body
      attribute :author_ip
      attribute :author_id
    end
  end
end
