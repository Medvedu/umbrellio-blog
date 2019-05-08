module Api
  module V1
    class UpdateViewLoginsPerUniqIpJob < ApplicationJob
      queue_as :default

      def perform(*args)
        _perform
      end

      private

      def _perform
        sql_query = <<~SQL
          REFRESH MATERIALIZED VIEW CONCURRENTLY logins_per_uniq_ip;
        SQL

        begin
          ROM.env.relations[:posts].read(sql_query).call
        rescue Exception => error
          puts "\n\nUpdateViewLoginsPerUniqIpJob raised an error: #{error}\n\n"
        end
      end
    end
  end
end
