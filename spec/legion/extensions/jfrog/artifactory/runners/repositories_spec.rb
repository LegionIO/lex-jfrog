# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog::Artifactory::Runners::Repositories do
  let(:client) { Legion::Extensions::Jfrog::Artifactory::Client.new(host: 'https://example.jfrog.io', token: 'tok') }
  let(:success_response) { instance_double(Faraday::Response, body: { 'key' => 'my-repo' }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: [{ 'key' => 'a' }, { 'key' => 'b' }], status: 200) }
  let(:connection) { instance_double(Faraday::Connection) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#create' do
    it 'sends a PUT to create a repository' do
      allow(connection).to receive(:put).with('/api/repositories/my-repo', anything).and_return(success_response)
      result = client.create(repo_key: 'my-repo', repo_type: 'local', package_type: 'generic')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get' do
    it 'fetches repository config' do
      allow(connection).to receive(:get).with('/api/repositories/my-repo').and_return(success_response)
      result = client.get(repo_key: 'my-repo')
      expect(result[:result]).to include('key' => 'my-repo')
    end
  end

  describe '#update' do
    it 'sends a POST to update a repository' do
      allow(connection).to receive(:post).with('/api/repositories/my-repo', anything).and_return(success_response)
      result = client.update(repo_key: 'my-repo', body: { description: 'updated' })
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete' do
    it 'sends a DELETE' do
      allow(connection).to receive(:delete).with('/api/repositories/my-repo').and_return(success_response)
      result = client.delete(repo_key: 'my-repo')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#list' do
    it 'lists all repositories' do
      allow(connection).to receive(:get).with('/api/repositories').and_return(list_response)
      result = client.list
      expect(result[:result].size).to eq(2)
    end

    it 'filters by type' do
      allow(connection).to receive(:get).with('/api/repositories?type=local').and_return(list_response)
      result = client.list(type: 'local')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#exists?' do
    it 'returns true when repo exists' do
      allow(connection).to receive(:get).with('/api/repositories/my-repo').and_return(success_response)
      result = client.exists?(repo_key: 'my-repo')
      expect(result[:result]).to be true
    end
  end
end
