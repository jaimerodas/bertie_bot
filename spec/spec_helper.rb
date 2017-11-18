# frozen_string_literal: true

require 'rack/test'

ENV['RACK_ENV'] = 'test'

require_relative '../app/bertie_bot'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    BertieBot
  end

  def directory
    '/tmp/bertie_bot_test'
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
