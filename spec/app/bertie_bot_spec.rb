# frozen_string_literal: true

require 'spec_helper'

describe BertieBot do
  before { stub_const('BertieBot::DATA_DIR', directory) }
  after { FileUtils.rm_r directory }

  let(:file_pattern) { /^\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\.\d{3}$/ }
  let(:payload) { { 'test' => 'test' } }

  describe 'POST #pull_requests' do
    subject do
      post '/pull_requests', payload.to_json, 'CONTENT_TYPE': 'application/json'
    end

    it 'creates the directory if it doesn\'t exist' do
      expect { subject }.to change { Dir.exist? directory }.to(true)
    end

    it 'stores the payload as JSON' do
      subject
      file = JSON.parse File.read("#{directory}/#{last_response.body}.json")
      expect(file).to eq payload
    end

    it 'returns the timestamp of creation' do
      subject

      # Is a successful response
      expect(last_response.status).to eq 201

      # Has a timestamp
      expect(last_response.body).to match file_pattern
    end
  end
end
