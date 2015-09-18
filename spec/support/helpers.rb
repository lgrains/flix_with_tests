require 'support/helpers/date_time_select_helpers'

RSpec.configure do |config|
  config.include Features::DateTimeSelectHelpers, type: :feature
end
