require 'database_cleaner/active_record'

RSpec.configure do |config|

  DatabaseCleaner.strategy = :deletion

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end
end


