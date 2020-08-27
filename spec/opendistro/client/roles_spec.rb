# frozen_string_literal: true

require 'spec_helper'

describe Opendistro::Client do
  describe '.roles' do
    before do
      stub_get('/_opendistro/_security/api/roles/', 'roles')
      @roles = Opendistro.roles
    end

    it 'gets the correct resource' do
      expect(a_get('/_opendistro/_security/api/roles/')).to have_been_made
    end

    it 'returns a of roles' do
      expect(@roles.first.first).to eq('readall_and_monitor')
    end
  end

  describe '.role' do
    context 'with role name passed' do
      before do
        stub_get('/_opendistro/_security/api/roles/my_test_role', 'role')
        @role = Opendistro.role('my_test_role')
      end

      it 'gets the correct resource' do
        expect(a_get('/_opendistro/_security/api/roles/my_test_role')).to have_been_made
      end

      it 'returns information about a role' do
        expect(@role.my_test_role.description).to eq('Custom permissions for a my_test_role')
      end
    end
  end

  describe '.create_role' do
    context 'when successful request' do
      before do
        @options = { cluster_permissions: ['cluster_composite_ops', 'indices_monitor'], index_permissions: [{ index_patterns: ['api*'], dls: '', fls: [], masked_fields: [], allowed_actions: ['read']}], tenant_permissions: [{ tenant_patterns: ['human_resources'], allowed_actions: ['kibana_all_read']}] }
        stub_put('/_opendistro/_security/api/roles/my_test_role', 'role_created').with(body: @options)
        @role = Opendistro.create_role('my_test_role', @options)
      end

      it 'gets the correct resource' do
        expect(a_put('/_opendistro/_security/api/roles/my_test_role').with(body: @options)).to have_been_made
      end

      it 'returns information about a created role' do
        expect(@role.status).to eq('CREATED')
      end
    end

    context 'when role exist' do
      it 'role_name updated' do
        stub_put('/_opendistro/_security/api/roles/my_test_role', 'role_exists')
        expect do
          Opendistro.create_role('my_test_role')
        end
      end
    end
  end

  describe '.edit_role' do
    before do
      @options = { cluster_permissions: ['cluster_composite_ops', 'indices_monitor'], index_permissions: [{ index_patterns: ['api-*'], dls: '', fls: [], masked_fields: [], allowed_actions: ['read']}], tenant_permissions: [{ tenant_pattern: ['human_resources'], allowed_actions: ['kibana_all_read']}] }
      stub_put('/_opendistro/_security/api/roles/my_test_role', 'role_updated').with(body: @options)
      @role = Opendistro.edit_role('my_test_role', @options)
    end

    it 'gets the correct resource' do
      expect(a_put('/_opendistro/_security/api/roles/my_test_role').with(body: @options)).to have_been_made
    end

    it 'returns information about a updated role' do
      expect(@role.status).to eq('OK')
    end
  end

  describe '.delete_role' do
    before do
      stub_delete('/_opendistro/_security/api/roles/my_test_role', 'role_deleted')
      @role = Opendistro.delete_role('my_test_role')
    end

    it 'gets the correct resource' do
      expect(a_delete('/_opendistro/_security/api/roles/my_test_role')).to have_been_made
    end

    it 'returns information about a deleted role' do
      expect(@role.status).to eq('OK')
    end
  end

  describe '.edit_role_artribute' do
    before do
      @options = { op: 'remove', path: '/index_permissions/0/dls' }
      stub_patch('/_opendistro/_security/api/roles/my_test_role', 'role_updated').with(body: @options)
      @role = Opendistro.edit_role_artribute('my_test_role', @options)
    end

    it 'gets the correct resource' do
      expect(a_patch('/_opendistro/_security/api/roles/my_test_role').with(body: @options)).to have_been_made
    end

    it 'returns information about updates individual attributes of a role' do
      expect(@role.status).to eq('OK')
    end
  end
end
