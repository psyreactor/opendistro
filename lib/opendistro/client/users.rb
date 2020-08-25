# frozen_string_literal: true

class Opendistro::Client
  # Defines methods related to users.
  # @see https://opendistro.github.io/for-elasticsearch-docs/docs/security/access-control/api/#users
  module Users
    # Gets a list of users.
    #
    # @example
    #   Opendistro.users
    #
    # @return [Opendistro::ObjectifiedHash]
    def users
      get('/_opendistro/_security/api/internalusers/')
    end

    # Gets information about a user.
    # Will return information about an authorized user if no user passed.
    #
    # @example
    #   Opendistro.user
    #   Opendistro.user('kibanero')
    #
    # @param  [String] name The name of a user.
    # @return [Opendistro::ObjectifiedHash]
    def user(username = nil)
      username.nil? ? get('/_opendistro/_security/api/account') : get("/_opendistro/_security/api/internalusers/#{username}")
    end

    # Creates a new user.
    # Requires authentication from an admin account.
    #
    # @example
    #   Opendistro.create_user('joe','secret', { attribute1: ...})
    #   or
    #   Opendistro.create_user('joe','secret', { description: 'user for test' })
    #
    # @param  [String] username(required) The username of a user.
    # @param  [String] password(required) The password of a user.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about created user.
    def create_user(username, password, options = {})
      raise ArgumentError, 'Missing required parameters' unless username || password

      put("/_opendistro/_security/api/internalusers/#{username}", body: { password: password }.merge!(options))
    end

    # Updates a user.
    #
    # @example
    #   Opendistro.edit_user('admin', [{ 'op' => 'replace', 'path': '/description', 'value': 'new description' }])
    #
    # @param  [Integer] id The ID of a user.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about created user.
    def edit_user(username, options = {})
      patch("/_opendistro/_security/api/internalusers/#{username}", body: options.to_json)
    end

    # Deletes a user.
    #
    # @example
    #   Opendistro.delete_user(1)
    #
    # @param [String] username The username of a user.
    # @return [Opendistro::ObjectifiedHash] Information about deleted user.
    def delete_user(username)
      delete("/_opendistro/_security/api/internalusers/#{username}")
    end
  end
end
