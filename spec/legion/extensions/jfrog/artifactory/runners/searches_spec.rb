# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog::Artifactory::Runners::Searches do
  let(:client) { Legion::Extensions::Jfrog::Artifactory::Client.new(host: 'https://example.jfrog.io', token: 'tok') }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'results' => [] }, status: 200) }
  let(:connection) { instance_double(Faraday::Connection) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#aql' do
    it 'posts an AQL query' do
      allow(connection).to receive(:post).with('/api/search/aql', 'items.find({"repo":"my-repo"})').and_return(ok_response)
      result = client.aql(query: 'items.find({"repo":"my-repo"})')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#artifact_search' do
    it 'searches by artifact name' do
      allow(connection).to receive(:get).with('/api/search/artifact', { name: 'foo.jar' }).and_return(ok_response)
      result = client.artifact_search(name: 'foo.jar')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#gavc_search' do
    it 'searches by group and artifact' do
      allow(connection).to receive(:get).with('/api/search/gavc', { g: 'com.example', a: 'my-lib' }).and_return(ok_response)
      result = client.gavc_search(group: 'com.example', artifact: 'my-lib')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#property_search' do
    it 'searches by properties' do
      allow(connection).to receive(:get).with('/api/search/prop', { 'build.name' => 'app' }).and_return(ok_response)
      result = client.property_search(properties: { 'build.name' => 'app' })
      expect(result[:status]).to eq(200)
    end
  end

  describe '#docker_repositories' do
    it 'lists docker repos' do
      allow(connection).to receive(:get).with('/api/docker/repositories').and_return(ok_response)
      result = client.docker_repositories
      expect(result[:status]).to eq(200)
    end
  end

  describe '#docker_tags' do
    it 'lists tags for a docker image' do
      allow(connection).to receive(:get).with('/api/docker/my-docker/v2/myimage/tags/list').and_return(ok_response)
      result = client.docker_tags(repo: 'my-docker', image: 'myimage')
      expect(result[:status]).to eq(200)
    end
  end
end
