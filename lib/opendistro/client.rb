# frozen_string_literal: true

module Opendistro
  # Wrapper for the Opendistro REST API.
  class Client < API
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }

    # Please keep in alphabetical order
    include Users

    # Text representation of the client, masking private token.
    #
    # @return [String]
    def inspect
      inspected = super
      inspected.sub! @password, only_show_last_four_chars(@password) if @password
      inspected
    end

    # Utility method for URL encoding of a string.
    # Copied from https://ruby-doc.org/stdlib-2.7.0/libdoc/erb/rdoc/ERB/Util.html
    #
    # @return [String]
    def url_encode(url)
      url.to_s.b.gsub(/[^a-zA-Z0-9_\-.~]/n) { |m| sprintf('%%%02X', m.unpack1('C')) } # rubocop:disable Style/FormatString, Style/FormatStringToken
    end

    def only_show_last_four_chars(password)
      "#{'*' * (password.size - 4)}#{password[-4..-1]}"
    end
  end
end
