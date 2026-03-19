# frozen_string_literal: true

module Legion
  module Extensions
    module Jfrog
      module Artifactory
        module Runners
          module Storage
            extend Legion::Extensions::Jfrog::Artifactory::Helpers::Client

            def empty_trash(**)
              response = client(**).post('/api/trash/empty')
              { result: response.body, status: response.status }
            end

            def delete_trash_item(path:, **)
              response = client(**).delete("/api/trash/items/#{path}")
              { result: response.body, status: response.status }
            end

            def restore_trash_item(path:, target:, **)
              body = { target: target }
              response = client(**).post("/api/trash/restore/#{path}", body)
              { result: response.body, status: response.status }
            end

            def run_garbage_collection(**)
              response = client(**).post('/api/system/storage/gc')
              { result: response.body, status: response.status }
            end

            def storage_info(**)
              response = client(**).get('/api/storageinfo')
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
