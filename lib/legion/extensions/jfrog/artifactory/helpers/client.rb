# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        module Helpers
          module Client
            def client(host:, token: nil, **)
              Faraday.new(url: host) do |conn|
                conn.request :json
                conn.response :json, content_type: /\bjson$/
                conn.headers['Content-Type'] = 'application/json'
                conn.headers['Authorization'] = "Bearer #{token}" if token
              end
            end
          end
        end
      end
    end
  end
end
