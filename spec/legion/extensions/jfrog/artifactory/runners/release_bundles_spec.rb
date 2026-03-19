# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog::Artifactory::Runners::ReleaseBundles do
  let(:client) { Legion::Extensions::Jfrog::Artifactory::Client.new(host: 'https://example.jfrog.io', token: 'tok') }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'name' => 'bundle1' }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: [{ 'name' => 'bundle1' }], status: 200) }
  let(:connection) { instance_double(Faraday::Connection) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_bundles' do
    it 'lists all release bundles' do
      allow(connection).to receive(:get).with('/api/release_bundles').and_return(list_response)
      result = client.list_bundles
      expect(result[:result]).to be_an(Array)
    end
  end

  describe '#list_versions' do
    it 'lists versions for a bundle' do
      allow(connection).to receive(:get).with('/api/release_bundles/bundle1/versions').and_return(list_response)
      result = client.list_versions(bundle_name: 'bundle1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_version' do
    it 'fetches a specific bundle version' do
      allow(connection).to receive(:get).with('/api/release_bundles/bundle1/1.0.0').and_return(ok_response)
      result = client.get_version(bundle_name: 'bundle1', version: '1.0.0')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_version' do
    it 'deletes a bundle version' do
      allow(connection).to receive(:delete).with('/api/release_bundles/bundle1/1.0.0').and_return(ok_response)
      result = client.delete_version(bundle_name: 'bundle1', version: '1.0.0')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#import_version' do
    it 'triggers import' do
      allow(connection).to receive(:post).with('/api/release_bundles/bundle1/1.0.0/import').and_return(ok_response)
      result = client.import_version(bundle_name: 'bundle1', version: '1.0.0')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#import_status' do
    it 'checks import status' do
      allow(connection).to receive(:get).with('/api/release_bundles/bundle1/1.0.0/import/status').and_return(ok_response)
      result = client.import_status(bundle_name: 'bundle1', version: '1.0.0')
      expect(result[:status]).to eq(200)
    end
  end
end
