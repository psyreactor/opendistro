# frozen_string_literal: true

require 'spec_helper'

describe Opendistro::Client do
  describe '.roles_mapping' do
    before do
      stub_get('/_opendistro/_security/api/rolesmapping', 'roles_mapping')
      @roles_mapping = Opendistro.roles_mapping
    end

    it 'gets the correct resource' do
      expect(a_get('/_opendistro/_security/api/rolesmapping')).to have_been_made
    end

    it 'returns a list of roles mapping' do
      expect(@roles_mapping.first.first).to eq('manage_snapshots')
    end
  end

  describe '.role_mapping' do
    context 'with role mapping name passed' do
      before do
        stub_get('/_opendistro/_security/api/rolesmapping/all_access', 'role_mapping')
        @role_mapping = Opendistro.role_mapping('all_access')
      end

      it 'gets the correct resource' do
        expect(a_get('/_opendistro/_security/api/rolesmapping/all_access')).to have_been_made
      end

      it 'returns information about a role mapping' do
        expect(@role_mapping.all_access.description).to eq('Maps admin to all_access')
      end
    end
  end

  describe '.create_role_mapping' do
    context 'when successful request' do
      before do
        @options = { backend_roles: ['starfleet', 'captains', 'defectors', 'cn=ldaprole', 'ou=groups', 'dc=example', 'dc=com'], hosts: ['*.starfleetintranet.com'], users: ['worf'] }
        stub_put('/_opendistro/_security/api/rolesmapping/my_test_role_mapping', 'role_mapping_created').with(body: @options)
        @role_mapping = Opendistro.create_role_mapping('my_test_role_mapping', @options)
      end

      it 'gets the correct resource' do
        expect(a_put('/_opendistro/_security/api/rolesmapping/my_test_role_mapping').with(body: @options)).to have_been_made
      end

      it 'returns information about a created role mapping' do
        expect(@role_mapping.status).to eq('CREATED')
      end
    end

    context 'when role mapping exist' do
      it 'role_mapping_name updated' do
        stub_put('/_opendistro/_security/api/rolesmappings/my_test_role_mapping', 'role_exists')
        expect do
          Opendistro.create_role_mapping('my_test_role_mapping')
        end
      end
    end
  end

  describe '.edit_role_mapping' do
    before do
      @options = { backend_roles: ['starfleet', 'captains', 'defectors', 'cn=ldaprole', 'ou=groups', 'dc=example', 'dc=com'], hosts: ['*.starfleetintranet.com'], users: ['worf'] }
      stub_put('/_opendistro/_security/api/rolesmapping/my_test_role_mapping', 'role_mapping_updated').with(body: @options)
      @role_mapping = Opendistro.edit_role_mapping('my_test_role_mapping', @options)
    end

    it 'gets the correct resource' do
      expect(a_put('/_opendistro/_security/api/rolesmapping/my_test_role_mapping').with(body: @options)).to have_been_made
    end

    it 'returns information about a updated role mapping' do
      expect(@role_mapping.status).to eq('OK')
    end
  end

  describe '.delete_role_mapping' do
    before do
      stub_delete('/_opendistro/_security/api/rolesmapping/my_test_role_mapping', 'role_mapping_deleted')
      @role_mapping = Opendistro.delete_role_mapping('my_test_role_mapping')
    end

    it 'gets the correct resource' do
      expect(a_delete('/_opendistro/_security/api/rolesmapping/my_test_role_mapping')).to have_been_made
    end

    it 'returns information about a deleted role mapping' do
      expect(@role_mapping.status).to eq('OK')
    end
  end

  describe '.edit_role_mapping_attribute' do
    before do
      @options = { op: 'replace', path: '/users', value: %w[myuser] }
      stub_patch('/_opendistro/_security/api/rolesmapping/my_test_role_mapping', 'role_mapping_updated').with(body: @options)
      @role_mapping = Opendistro.edit_role_mapping_attribute('my_test_role_mapping', @options)
    end

    it 'gets the correct resource' do
      expect(a_patch('/_opendistro/_security/api/rolesmapping/my_test_role_mapping').with(body: @options)).to have_been_made
    end

    it 'returns information about updates individual attributes of a role mapping' do
      expect(@role_mapping.status).to eq('OK')
    end
  end
end
