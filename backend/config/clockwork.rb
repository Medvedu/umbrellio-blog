require 'clockwork'
require 'active_support/time'

require './config/boot'
require './config/environment'

module Clockwork
  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every 45.seconds, 'update_view_logins_per_uniq_ip' do
    Api::V1::UpdateViewLoginsPerUniqIpJob.perform_now
  end
end
