# frozen_string_literal: true

require 'spec_helper'

describe Opendistro::Request do
  before do
    # Prevent tests modifying the `default_params` value from causing cross-test
    # pollution
    described_class.default_params.delete(:sudo)

    @request = described_class.new
  end

  it { is_expected.to respond_to :get }
  it { is_expected.to respond_to :post }
  it { is_expected.to respond_to :put }
  it { is_expected.to respond_to :delete }

  describe '.default_options' do
    it 'has default values' do
      default_options = described_class.default_options
      expect(default_options).to be_a Hash
      expect(default_options[:parser]).to be_a Proc
      expect(default_options[:format]).to eq(:json)
      expect(default_options[:headers]).to eq('Accept' => 'application/json', 'Content-Type' => 'application/json')
      expect(default_options[:default_params]).to be_empty
    end
  end

  describe '.parse' do
    it 'returns ObjectifiedHash' do
      body = JSON.unparse(a: 1, b: 2)
      expect(described_class.parse(body)).to be_an Opendistro::ObjectifiedHash
      expect(described_class.parse('true')).to be true
      expect(described_class.parse('false')).to be false

      expect { described_class.parse('string') }.to raise_error(Opendistro::Error::Parsing)
    end
  end

  describe '#request_defaults' do
    context 'when endpoint is not set' do
      it 'raises Error::MissingCredentials' do
        @request.endpoint = nil
        expect do
          @request.request_defaults
        end.to raise_error(Opendistro::Error::MissingCredentials, 'Please set an endpoint to API')
      end
    end
  end

  describe 'HTTP request methods' do
    it 'does not overwrite headers set via HTTParty configuration' do
      @request.username = 'pepe'
      @request.password = 'rompe'
      @request.endpoint = 'https://example.com:9200'
      path = "#{@request.endpoint}"
      auth = Base64.strict_encode64("#{@request.username}:#{@request.password}")

      # Stub Opendistro::Configuration
      allow(@request).to receive(:httparty).and_return(
        headers: { 'Cookie' => 'opendistro_canary=true' }
      )

      stub_request(:get, path)
      @request.get('/')

      expect(a_request(:get, path).with(headers: {
        'Authorization' => "Basic #{auth}",
        'Cookie' => 'opendistro_canary=true',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
      }.merge(described_class.headers))).to have_been_made
    end
  end

  describe '#authorization_header' do
    it 'raises MissingCredentials when auth_token and private_token are not set' do
      expect do
        @request.send(:authorization_header)
      end.to raise_error(Opendistro::Error::MissingCredentials)
    end

    it 'sets the correct header when given a private_token' do
      @request.password = 'rompe'
      @request.username = 'pepe'
      auth = Base64.encode64("#{@request.username}:#{@request.password}")
      expect(@request.send(:authorization_header)).to eq('Authorization' => "Basic #{auth}")
    end
  end
end
