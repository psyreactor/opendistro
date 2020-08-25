# frozen_string_literal: true

require 'spec_helper'

describe Opendistro::Client do
  describe '.flush_cache' do
    before do
      stub_delete('/_opendistro/_security/api/cache', 'cache_flushed')
      @cache = Opendistro.flush_cache
    end

    it 'gets the correct resource' do
      expect(a_delete('/_opendistro/_security/api/cache')).to have_been_made
    end

    it 'returns confirmation if the cache was flushed successfully' do
      expect(@cache.status).to eq('OK')
    end
  end
end
