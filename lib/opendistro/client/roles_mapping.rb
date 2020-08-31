# frozen_string_literal: true

class Opendistro::Client
  # Defines methods related to roles.
  # @see https://opendistro.github.io/for-elasticsearch-docs/docs/security/access-control/api/#role-mappings
  module RolesMapping
    # Retrieves all roles mapping.
    #
    # @example
    #   Opendistro.roles_mapping
    #
    # @return [Opendistro::ObjectifiedHash]
    def roles_mapping
      get('/_opendistro/_security/api/rolesmapping')
    end

    # Retrieves one role mapping.
    # Will return information about a role mapping.
    #
    # @example
    #   Opendistro.role_mapping('kibana_user')
    #
    # @param  [String] name The name of a role mapping.
    # @return [Opendistro::ObjectifiedHash]
    def role_mapping(name = nil)
      name.nil? ? get('/_opendistro/_security/api/rolesmapping/') : get("/_opendistro/_security/api/rolesmapping/#{name}")
    end

    # Creates or replaces the specified role mapping.
    # Requires authentication from an admin account.
    #
    # @example
    #   Opendistro.create_role_mapping('my_test_role_mapping', { attribute1: ...})
    #   or
    #   Opendistro.create_role_mapping('my_test_role_mapping', {"backend_roles":["starfleet","captains","defectors","cn=ldaprole,ou=groups,dc=example,dc=com"],"hosts":["*.starfleetintranet.com" ],"users":["worf" ]})
    #
    # @param  [String] name (required) The name of a role mapping.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about created role mapping.
    def create_role_mapping(name, options = {})
      raise ArgumentError, 'Missing required parameters' unless name

      put("/_opendistro/_security/api/rolesmapping/#{name}", body: options)
    end
    alias role_mapping_create create_role_mapping

    # Updates a role mapping.
    #
    # @example
    #   Opendistro.edit_role_mapping('my_test_role_mapping', {"backend_roles":["starfleet","captains","defectors","cn=ldaprole,ou=groups,dc=example,dc=com"],"hosts":["*.starfleetintranet.com" ],"users":["worf" ]})
    #
    # @param  [String] name The name of a role mapping.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about updated role mapping.
    def edit_role_mapping(name, options = {})
      put("/_opendistro/_security/api/rolesmapping/#{name}", body: options.to_json)
    end
    alias role_mapping_edit edit_role_mapping

    # Deletes a role mapping.
    #
    # @example
    #   Opendistro.delete_role_mapping('my_test_role_mapping')
    #
    # @param [String] name The name of a role mapping.
    # @return [Opendistro::ObjectifiedHash] Information about deleted role mapping.
    def delete_role_mapping(name)
      delete("/_opendistro/_security/api/rolesmapping/#{name}")
    end
    alias role_mapping_delete delete_role_mapping

    # Updates individual attributes of a role mapping.
    #
    # @example
    #   Opendistro.edit_role_mapping_attribute('my_test_role_mapping', [{"op": "replace", "path": "/users", "value": ["myuser"]}])
    #   or
    #   Opendistro.edit_role_mapping_attribute('my_test_role_mapping', [{"op": "replace", "path": "/backend_roles", "value": ["mybackendrole"]}])
    #
    # @param  [String] name The name of a role mapping.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about updated role mapping.
    def edit_role_mapping_attribute(name, options = {})
      patch("/_opendistro/_security/api/rolesmapping/#{name}", body: options)
    end
    alias role_mapping_edit_attribute edit_role_mapping_attribute
  end
end
