# frozen_string_literal: true

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        module Runners
          module Searches
            extend Legion::Extensions::Jfrog::Artifactory::Helpers::Client

            def aql(query:, **)
              response = client(**).post('/api/search/aql', query)
              { result: response.body, status: response.status }
            end

            def artifact_search(name:, repos: nil, **)
              params = { name: name }
              params[:repos] = repos if repos
              response = client(**).get('/api/search/artifact', params)
              { result: response.body, status: response.status }
            end

            def gavc_search(group: nil, artifact: nil, version: nil, classifier: nil, repos: nil, **)
              params = {}
              params[:g] = group if group
              params[:a] = artifact if artifact
              params[:v] = version if version
              params[:c] = classifier if classifier
              params[:repos] = repos if repos
              response = client(**).get('/api/search/gavc', params)
              { result: response.body, status: response.status }
            end

            def property_search(properties:, repos: nil, **)
              params = properties.dup
              params[:repos] = repos if repos
              response = client(**).get('/api/search/prop', params)
              { result: response.body, status: response.status }
            end

            def checksum_search(checksum:, repos: nil, **)
              headers = { 'X-Checksum-Sha256' => checksum }
              params = {}
              params[:repos] = repos if repos
              response = client(**).get('/api/search/checksum', params) do |req|
                req.headers.merge!(headers)
              end
              { result: response.body, status: response.status }
            end

            def usage_search(not_used_since:, repos: nil, **)
              params = { notUsedSince: not_used_since }
              params[:repos] = repos if repos
              response = client(**).get('/api/search/usage', params)
              { result: response.body, status: response.status }
            end

            def date_range_search(from:, to: nil, repos: nil, **)
              params = { from: from }
              params[:to] = to if to
              params[:repos] = repos if repos
              response = client(**).get('/api/search/dates', params)
              { result: response.body, status: response.status }
            end

            def pattern_search(pattern:, **)
              response = client(**).get('/api/search/pattern', pattern: pattern)
              { result: response.body, status: response.status }
            end

            def docker_repositories(**)
              response = client(**).get('/api/docker/repositories')
              { result: response.body, status: response.status }
            end

            def docker_tags(repo:, image:, **)
              response = client(**).get("/api/docker/#{repo}/v2/#{image}/tags/list")
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
