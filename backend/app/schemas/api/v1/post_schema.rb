require 'dry-validation'

module Api
  module V1
    PostSchema = Dry::Validation.Schema do
      required(:title).filled(:str?, max_size?: 30)
      required(:body).filled(:str?, max_size?: 10_000)
      required(:author_login).filled(:str?, max_size?: 15)
    end
  end
end
