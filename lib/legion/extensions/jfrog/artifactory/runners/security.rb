# frozen_string_literal: true

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        module Runners
          module Security
            extend Legion::Extensions::Jfrog::Artifactory::Helpers::Client

            def get_user(username:, **)
              response = client(**).get("/api/security/users/#{username}")
              { result: response.body, status: response.status }
            end

            def list_permissions(**)
              response = client(**).get('/api/security/permissions')
              { result: response.body, status: response.status }
            end

            def get_permission(permission_name:, **)
              response = client(**).get("/api/security/permissions/#{permission_name}")
              { result: response.body, status: response.status }
            end

            def create_permission(permission_name:, body:, **)
              response = client(**).put("/api/security/permissions/#{permission_name}", body)
              { result: response.body, status: response.status }
            end

            def delete_permission(permission_name:, **)
              response = client(**).delete("/api/security/permissions/#{permission_name}")
              { result: response.body, status: response.status }
            end

            def create_api_key(**)
              response = client(**).post('/api/security/apiKey')
              { result: response.body, status: response.status }
            end

            def get_api_key(**)
              response = client(**).get('/api/security/apiKey')
              { result: response.body, status: response.status }
            end

            def revoke_api_key(**)
              response = client(**).delete('/api/security/apiKey')
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
