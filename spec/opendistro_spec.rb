# frozen_string_literal: true

require 'spec_helper'

describe Opendistro do
  after { described_class.reset }

  describe '.client' do
    it 'is a Opendistro::Client' do
      expect(described_class.client).to be_a Opendistro::Client
    end

    it 'does not override each other' do
      client1 = described_class.client(endpoint: 'https://api1.example.com', username: 'pedro', password: 'qwerty')
      client2 = described_class.client(endpoint: 'https://api2.example.com', username: 'luis', password: 'poiuyt', verify_ssl: false)
      expect(client1.endpoint).to eq('https://api1.example.com')
      expect(client2.endpoint).to eq('https://api2.example.com')
      expect(client1.username).to eq('pedro')
      expect(client1.verify_ssl).to be true
      expect(client2.password).to eq('poiuyt')
    end
  end

  describe '.actions' do
    it 'returns an array of client methods' do
      actions = described_class.actions
      expect(actions).to be_an Array
      expect(actions.first).to be_a Symbol
      expect(actions.min).to eq(:create_role)
    end
  end

  describe '.endpoint=' do
    it 'sets endpoint' do
      described_class.endpoint = 'https://api.example.com'
      expect(described_class.endpoint).to eq('https://api.example.com')
    end
  end

  describe '.password=' do
    it 'sets password' do
      described_class.password = 'secret'
      expect(described_class.password).to eq('secret')
    end
  end

  describe '.username' do
    it 'sets username', focus: true do
      described_class.username = 'root'
      expect(described_class.username).to eq('root')
    end
  end

  describe '.verify_ssl' do
    it 'sets verify_ssl' do
      described_class.verify_ssl = false
      expect(described_class.verify_ssl).to be false
    end
  end

  describe '.ca_cert' do
    it 'sets ca_cert' do
      described_class.ca_cert = '/etc/pki/ca_bundle.pem'
      expect(described_class.ca_cert).to eq('/etc/pki/ca_bundle.pem')
    end
  end

  describe '.user_agent' do
    it 'returns default user_agent' do
      expect(described_class.user_agent).to eq(Opendistro::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe '.user_agent=' do
    it 'sets user_agent' do
      described_class.user_agent = 'Custom User Agent'
      expect(described_class.user_agent).to eq('Custom User Agent')
    end
  end

  describe '.configure' do
    Opendistro::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "sets #{key}" do
        described_class.configure do |config|
          config.send("#{key}=", key)
          expect(described_class.send(key)).to eq(key)
        end
      end
    end
  end

  describe '.http_proxy' do
    it 'delegates the method to Opendistro::Request' do
      described_class.endpoint = 'https://api.example.com'
      request = class_spy(Opendistro::Request).as_stubbed_const

      described_class.http_proxy('proxy.example.net', 1987, 'user', 'pass')
      expect(request).to have_received(:http_proxy).with('proxy.example.net', 1987, 'user', 'pass')
    end
  end
end
