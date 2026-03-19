# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog::Artifactory::Runners::Security do
  let(:client) { Legion::Extensions::Jfrog::Artifactory::Client.new(host: 'https://example.jfrog.io', token: 'tok') }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'name' => 'admin' }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: [{ 'name' => 'perm1' }], status: 200) }
  let(:connection) { instance_double(Faraday::Connection) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#get_user' do
    it 'fetches user details' do
      allow(connection).to receive(:get).with('/api/security/users/admin').and_return(ok_response)
      result = client.get_user(username: 'admin')
      expect(result[:result]).to include('name' => 'admin')
    end
  end

  describe '#list_permissions' do
    it 'lists all permission targets' do
      allow(connection).to receive(:get).with('/api/security/permissions').and_return(list_response)
      result = client.list_permissions
      expect(result[:result]).to be_an(Array)
    end
  end

  describe '#get_permission' do
    it 'fetches a specific permission target' do
      allow(connection).to receive(:get).with('/api/security/permissions/my-perm').and_return(ok_response)
      result = client.get_permission(permission_name: 'my-perm')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_permission' do
    it 'creates a permission target' do
      body = { repositories: ['my-repo'] }
      allow(connection).to receive(:put).with('/api/security/permissions/new-perm', body).and_return(ok_response)
      result = client.create_permission(permission_name: 'new-perm', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_permission' do
    it 'deletes a permission target' do
      allow(connection).to receive(:delete).with('/api/security/permissions/old-perm').and_return(ok_response)
      result = client.delete_permission(permission_name: 'old-perm')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_api_key' do
    it 'creates an API key' do
      allow(connection).to receive(:post).with('/api/security/apiKey').and_return(ok_response)
      result = client.create_api_key
      expect(result[:status]).to eq(200)
    end
  end

  describe '#revoke_api_key' do
    it 'revokes the API key' do
      allow(connection).to receive(:delete).with('/api/security/apiKey').and_return(ok_response)
      result = client.revoke_api_key
      expect(result[:status]).to eq(200)
    end
  end
end
