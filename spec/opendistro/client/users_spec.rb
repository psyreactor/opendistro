# frozen_string_literal: true

require 'spec_helper'

describe Opendistro::Client do
  describe '.users' do
    before do
      stub_get('/_opendistro/_security/api/internalusers/', 'users')
      @users = Opendistro.users
    end

    it 'gets the correct resource' do
      expect(a_get('/_opendistro/_security/api/internalusers/')).to have_been_made
    end

    it 'returns a of users' do
      expect(@users.first.first).to eq('logstash')
    end
  end

  describe '.user' do
    context 'with user name passed' do
      before do
        stub_get('/_opendistro/_security/api/internalusers/pedro', 'user')
        @user = Opendistro.user('pedro')
      end

      it 'gets the correct resource' do
        expect(a_get('/_opendistro/_security/api/internalusers/pedro')).to have_been_made
      end

      it 'returns information about a user' do
        expect(@user.pedro.description).to eq('usuario pedro')
      end
    end
  end

  describe '.create_user' do
    context 'when successful request' do
      before do
        stub_put('/_opendistro/_security/api/internalusers/pedro', 'user_created')
        @user = Opendistro.create_user('pedro', '1234.rewq')
      end

      it 'gets the correct resource' do
        body = { password: '1234.rewq' }
        expect(a_put('/_opendistro/_security/api/internalusers/pedro').with(body: body)).to have_been_made
      end

      it 'returns information about a created user' do
        expect(@user.status).to eq('CREATED')
      end
    end

    context 'when user exist' do
      it 'throws an exception' do
        stub_put('/_opendistro/_security/api/internalusers/pedro', 'user_exists')
        expect do
          Opendistro.create_user('pedro', '1234.rewq')
        end
      end
    end
  end

  describe '.edit_user' do
    before do
      @options = { password: '1234.rewq' }
      stub_patch('/_opendistro/_security/api/internalusers/pedro', 'user_exists').with(body: @options)
      @user = Opendistro.edit_user('pedro', @options)
    end

    it 'gets the correct resource' do
      expect(a_patch('/_opendistro/_security/api/internalusers/pedro').with(body: @options)).to have_been_made
    end
  end

  describe '.delete_user' do
    before do
      stub_delete('/_opendistro/_security/api/internalusers/pedro', 'user_deleted')
      @user = Opendistro.delete_user('pedro')
    end

    it 'gets the correct resource' do
      expect(a_delete('/_opendistro/_security/api/internalusers/pedro')).to have_been_made
    end

    it 'returns information about a deleted user' do
      expect(@user.status).to eq('OK')
    end
  end
end
