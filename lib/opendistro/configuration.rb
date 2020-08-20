# frozen_string_literal: true

module Opendistro
  # Defines constants and methods related to configuration.
  module Configuration
    # An array of valid keys in the options hash when configuring a Opendistro::API.
    VALID_OPTIONS_KEYS = %i[endpoint username password ca_cert httparty user_agent verify_ssl].freeze

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "Opendistro Ruby Gem #{Opendistro::VERSION}"
    DEFAULT_VERIFY_SSL = true
    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # Sets all configuration options to their default values
    # when this module is extended.
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block.
    def configure
      yield self
    end

    # Creates a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Resets all configuration options to the defaults.
    def reset
      self.endpoint       = ENV['OPENDISTRO_API_ENDPOINT']
      self.username       = ENV['OPENDISTRO_API_USER']
      self.password       = ENV['OPENDISTRO_API_PASSWORD']
      self.ca_cert        = ENV['OPENDISTRO_API_CA_CERT_PATH']
      self.httparty       = get_httparty_config(ENV['OPENDISTRO_API_HTTPARTY_OPTIONS'])
      self.user_agent     = DEFAULT_USER_AGENT
      self.verify_ssl     = ENV['OPENDISTRO_API_VERIFY_SSL'] || DEFAULT_VERIFY_SSL
    end
    
    private

    # Allows HTTParty config to be specified in ENV using YAML hash.
    def get_httparty_config(options)
      return if options.nil?

      httparty = Opendistro::CLI::Helpers.yaml_load(options)
      raise ArgumentError, 'HTTParty config should be a Hash.' unless httparty.is_a? Hash

      Opendistro::CLI::Helpers.symbolize_keys httparty
    end
  end
end
