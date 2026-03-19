# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/repositories'
require_relative 'runners/searches'
require_relative 'runners/security'
require_relative 'runners/storage'
require_relative 'runners/release_bundles'

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        class Client
          include Helpers::Client
          include Runners::Repositories
          include Runners::Searches
          include Runners::Security
          include Runners::Storage
          include Runners::ReleaseBundles

          attr_reader :opts

          def initialize(host:, token: nil, **extra)
            @opts = { host: host, token: token, **extra }.compact
          end

          def client(**override)
            super(**@opts, **override)
          end
        end
      end
    end
  end
end
