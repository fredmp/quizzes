ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require "database_cleaner"

Rails.backtrace_cleaner.remove_silencers!

Rails.configuration.answers_limit_by_question = 4

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods
  config.profile_examples = 10
  config.order = :random

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  def create_questions_in_sequence(quantity)
    (1..quantity).each do |q|
      question = create(:question, text: "Question text #{q}")
      create(:answer, text: "Answer - 1", question: question, correct: true)
      create(:answer, text: "Answer - 2", question: question, correct: false)
      create(:answer, text: "Answer - 3", question: question, correct: false)
      create(:answer, text: "Answer - 4", question: question, correct: false)
    end
  end

end
