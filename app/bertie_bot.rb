# frozen_string_literal: true

require 'sinatra'

# A simple app that stores whatever is sent to it
class BertieBot < Sinatra::Base
  DATA_DIR = '/tmp/bertie_bot'

  post '/pull_requests' do
    Dir.mkdir DATA_DIR unless Dir.exist? DATA_DIR
    save(request.body.read)

    status 201
    body timestamp
  end

  private

  def timestamp
    @timestamp ||= Time.now.strftime('%F %T.%L')
  end

  def save(body)
    File.write(
      "#{DATA_DIR}/#{timestamp}.json",
      JSON.pretty_generate(JSON.parse(body))
    )
  end
end
