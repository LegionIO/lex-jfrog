# frozen_string_literal: true

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        module Runners
          module Repositories
            extend Legion::Extensions::Jfrog::Artifactory::Helpers::Client

            def create(repo_key:, repo_type:, package_type:, **)
              body = { key: repo_key, rclass: repo_type, packageType: package_type }
              response = client(**).put("/api/repositories/#{repo_key}", body)
              { result: response.body, status: response.status }
            end

            def get(repo_key:, **)
              response = client(**).get("/api/repositories/#{repo_key}")
              { result: response.body, status: response.status }
            end

            def update(repo_key:, body: {}, **)
              response = client(**).post("/api/repositories/#{repo_key}", body)
              { result: response.body, status: response.status }
            end

            def delete(repo_key:, **)
              response = client(**).delete("/api/repositories/#{repo_key}")
              { result: response.body, status: response.status }
            end

            def list(type: nil, **)
              path = '/api/repositories'
              path += "?type=#{type}" if type
              response = client(**).get(path)
              { result: response.body, status: response.status }
            end

            def exists?(repo_key:, **)
              response = client(**).get("/api/repositories/#{repo_key}")
              { result: response.status == 200, status: response.status }
            end

            def create_batch(repositories:, **)
              response = client(**).put('/api/repositories', repositories)
              { result: response.body, status: response.status }
            end

            def update_batch(repositories:, **)
              response = client(**).post('/api/repositories', repositories)
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
