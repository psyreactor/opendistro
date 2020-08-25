# frozen_string_literal: true

class Opendistro::Client
  # Defines methods related to cache.
  # @see https://opendistro.github.io/for-elasticsearch-docs/docs/security/access-control/api/#flush-cache
  module Cache
    # Flushes the security plugin user, authentication, and authorization cache.
    #
    # @example
    #   Opendistro.flush_cache
    #
    # @return [Opendistro::ObjectifiedHash]
    def flush_cache
      delete("/_opendistro/_security/api/cache")
    end
  end
end
