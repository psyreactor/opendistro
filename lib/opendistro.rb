# frozen_string_literal: true

require 'opendistro/version'
require 'opendistro/objectified_hash'
require 'opendistro/configuration'
require 'opendistro/error'
require 'opendistro/file_response'
require 'opendistro/request'
require 'opendistro/api'
require 'opendistro/client'

module Opendistro
  extend Configuration

  # Alias for Opendistro::Client.new
  #
  # @return [Opendistro::Client]
  def self.client(options = {})
    Opendistro::Client.new(options)
  end

  # Delegate to Opendistro::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end

  # Delegate to Opendistro::Client
  def self.respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name) || super
  end

  # Delegate to HTTParty.http_proxy
  def self.http_proxy(address = nil, port = nil, username = nil, password = nil)
    Opendistro::Request.http_proxy(address, port, username, password)
  end

  # Returns an unsorted array of available client methods.
  #
  # @return [Array<Symbol>]
  def self.actions
    hidden =
      /endpoint|username|password|user_agent|ca_cert|verify_ssl|get|post|put|\Adelete\z|validate\z|request_defaults|httparty/
    (Opendistro::Client.instance_methods - Object.methods).reject { |e| e[hidden] }
  end
end
