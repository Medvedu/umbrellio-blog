require 'rom-repository'

module Api
  module V1
    class PostRepository < ROM::Repository[:posts]
      commands :create

      # @return [ROM::Relation::Loaded]
      def find_authors_with_same_ip
        sql_query = <<~SQL
          SELECT ip, logins
          FROM logins_per_uniq_ip
        SQL

        posts.read(sql_query).call
      end

      # @return [ROM::Relation::Loaded]
      def get_top_posts_by_avg_rate
        posts.select { [title, body] }
             .where { rate_count > 0 }
             .order { ROUND(rate_sum / rate_count, 4).desc }
             .limit(555)
             .call
      end

      # @return [Hash]
      def create_with_user(data)
        posts.transaction do
          author = user_repo.create_if_not_exists(data[:author_login])

          new_post = posts.map_to(Post)
                          .changeset(:create, data)
                          .associate(author)

          struct_post = new_post.commit
          struct_post.viewable
        end
      end

      # @return [TrueClass, FalseClass]
      def exist?(post_id)
        posts.where(id: post_id).exist?
      end

      private

      # @return [Api::V1::UserRepository]
      def user_repo
        UserRepository.new(ROM.env)
      end
    end
  end
end
