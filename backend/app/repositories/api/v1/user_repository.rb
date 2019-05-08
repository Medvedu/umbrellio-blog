require 'rom-repository'

module Api
  module V1
    class UserRepository < ROM::Repository[:users]
      commands :create

      # @return [ROM::Struct::User]
      def create_if_not_exists(login)
        user_query = users.where(login: login)

        if user_query.exist?
          user_query.first
        else
          users.command(:create).call(login: login)
        end
      end
    end
  end
end
