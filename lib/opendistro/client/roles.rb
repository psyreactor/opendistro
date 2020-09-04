# frozen_string_literal: true

class Opendistro::Client
  # Defines methods related to roles.
  # @see https://opendistro.github.io/for-elasticsearch-docs/docs/security/access-control/api/#roles
  module Roles
    # Retrieves all roles.
    #
    # @example
    #   Opendistro.roles
    #
    # @return [Opendistro::ObjectifiedHash]
    def roles
      get('/_opendistro/_security/api/roles/')
    end

    # Retrieves one role.
    # Will return information about an authorized role if no role passed.
    #
    # @example
    #   Opendistro.role
    #   Opendistro.role('kibana_user')
    #
    # @param  [String] name The name of a role.
    # @return [Opendistro::ObjectifiedHash]
    def role(rolename = nil)
      rolename.nil? ? get('/_opendistro/_security/api/roles/') : get("/_opendistro/_security/api/roles/#{rolename}")
    end

    # Creates or replaces the specified role.
    # Requires authentication from an admin account.
    #
    # @example
    #   Opendistro.create_role('my_test_role', { attribute1: ...})
    #   or
    #   Opendistro.create_role('my_test_role', { "cluster_permissions":["cluster_composite_ops","indices_monitor"],"index_permissions":[{"index_patterns":["api-*"],"dls":"","fls":[],"masked_fields":[],"allowed_actions":["read"]}],"tenant_permissions":[{"tenant_patterns":["human_resources"],"allowed_actions":["kibana_all_read"]}]})
    #
    # @param  [String] rolename (required) The rolename of a role.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about created role.
    def create_role(rolename, options = {})
      raise ArgumentError, 'Missing required parameters' unless rolename

      put("/_opendistro/_security/api/roles/#{rolename}", body: options)
    end
    alias role_create create_role

    # Updates a role.
    #
    # @example
    #   Opendistro.edit_role('my_test_role', { "cluster_permissions":["cluster_composite_ops","indices_monitor"],"index_permissions":[{"index_patterns":["api*"],"dls":"","fls":[],"masked_fields":[],"allowed_actions":["read"]}],"tenant_permissions":[{"tenant_patterns":["human_resources"],"allowed_actions":["kibana_all_read"]}]})
    #
    # @param  [String] rolename The rolename of a role.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about updated role.
    def edit_role(rolename, options = {})
      put("/_opendistro/_security/api/roles/#{rolename}", body: options.to_json)
    end
    alias role_edit edit_role

    # Deletes a role.
    #
    # @example
    #   Opendistro.delete_role('my_test_role')
    #
    # @param [String] rolename The rolename of a role.
    # @return [Opendistro::ObjectifiedHash] Information about deleted role.
    def delete_role(rolename)
      delete("/_opendistro/_security/api/roles/#{rolename}")
    end
    alias role_delete delete_role

    # Updates individual attributes of a role.
    #
    # @example
    #   Opendistro.edit_role_attribute('my_test_role', [{"op": "remove", "path": "/index_permissions/0/dls"}])
    #   or
    #   Opendistro.edit_role_attribute('my_test_role', [{"op": "replace", "path": "/index_permissions/0/fls", "value": ["myfield1", "myfield2"]}])
    #
    # @param  [String] rolename The rolename of a role.
    # @param  [Hash] options A customizable set of options.
    # @return [Opendistro::ObjectifiedHash] Information about updated role.
    def edit_role_attribute(rolename, options = {})
      patch("/_opendistro/_security/api/roles/#{rolename}", body: options.to_json)
    end
    alias role_edit_attribute edit_role_attribute
  end
end
