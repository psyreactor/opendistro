# frozen_string_literal: true

require 'httparty'
require 'json'

module Opendistro
  # @private
  class Request
    include HTTParty
    format :json
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    parser(proc { |body, _| parse(body) })

    attr_accessor :username, :password, :verify_ssl, :ca_cert, :endpoint

    # Converts the response body to an ObjectifiedHash.
    def self.parse(body)
      body = decode(body)

      if body.is_a? Hash
        ObjectifiedHash.new body
      elsif body.is_a? Array
        PaginatedResponse.new(body.collect! { |e| ObjectifiedHash.new(e) })
      elsif body
        true
      elsif !body
        false
      elsif body.nil?
        false
      else
        raise Error::Parsing, "Couldn't parse a response body"
      end
    end

    # Decodes a JSON response into Ruby object.
    def self.decode(response)
      response ? JSON.parse(response) : {}
    rescue JSON::ParserError
      raise Error::Parsing, 'The response is not a valid JSON'
    end

    %w[get post put delete patch].each do |method|
      define_method method do |path, options = {}|
        params = options.dup

        httparty_config(params)

        params[:headers] ||= {}
        params[:headers].merge!(authorization_header)

        params[:ssl_ca_file] = @ca_cert unless @ca_cert.nil?
        params[:verify] = @verify_ssl unless @verify_ssl
        params[:body] = params[:body].to_json if params[:body].is_a? Hash

        validate self.class.send(method, @endpoint + path, params)
      end
    end

    # Checks the response code for common errors.
    # Returns parsed response for successful requests.
    def validate(response)
      error_klass = Error::STATUS_MAPPINGS[response.code]
      raise error_klass, response if error_klass

      parsed = response.parsed_response
      parsed.client = self if parsed.respond_to?(:client=)
      parsed.parse_headers!(response.headers) if parsed.respond_to?(:parse_headers!)
      parsed
    end

    # Sets a base_uri and default_params for requests.
    # @raise [Error::MissingCredentials] if endpoint not set.
    def request_defaults
      raise Error::MissingCredentials, 'Please set an endpoint to API' unless @endpoint
    end

    private

    # Returns an Authorization header hash
    #
    # @raise [Error::MissingCredentials] if private_token and auth_token are not set.
    def authorization_header
      raise Error::MissingCredentials, 'Please provide a private_token or auth_token for user' if @username.nil? || @password.nil?

      auth = Base64.encode64("#{@username}:#{@password}")
      { 'Authorization' => "Basic #{auth}" }
    end

    # Set HTTParty configuration
    # @see https://github.com/jnunemaker/httparty
    def httparty_config(options)
      options.merge!(httparty) if httparty
    end
  end
end
