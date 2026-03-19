# frozen_string_literal: true

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        module Runners
          module ReleaseBundles
            extend Legion::Extensions::Jfrog::Artifactory::Helpers::Client

            def list_bundles(**)
              response = client(**).get('/api/release_bundles')
              { result: response.body, status: response.status }
            end

            def list_versions(bundle_name:, **)
              response = client(**).get("/api/release_bundles/#{bundle_name}/versions")
              { result: response.body, status: response.status }
            end

            def get_version(bundle_name:, version:, **)
              response = client(**).get("/api/release_bundles/#{bundle_name}/#{version}")
              { result: response.body, status: response.status }
            end

            def delete_version(bundle_name:, version:, **)
              response = client(**).delete("/api/release_bundles/#{bundle_name}/#{version}")
              { result: response.body, status: response.status }
            end

            def import_version(bundle_name:, version:, **)
              response = client(**).post("/api/release_bundles/#{bundle_name}/#{version}/import")
              { result: response.body, status: response.status }
            end

            def import_status(bundle_name:, version:, **)
              response = client(**).get("/api/release_bundles/#{bundle_name}/#{version}/import/status")
              { result: response.body, status: response.status }
            end

            include Legion::Extensions::Helpers::Lex if Legion::Extensions.const_defined?(:Helpers) &&
                                                        Legion::Extensions::Helpers.const_defined?(:Lex)
          end
        end
      end
    end
  end
end
