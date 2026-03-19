# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog::Artifactory::Runners::Storage do
  let(:client) { Legion::Extensions::Jfrog::Artifactory::Client.new(host: 'https://example.jfrog.io', token: 'tok') }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'message' => 'ok' }, status: 200) }
  let(:connection) { instance_double(Faraday::Connection) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#empty_trash' do
    it 'empties the trash can' do
      allow(connection).to receive(:post).with('/api/trash/empty').and_return(ok_response)
      result = client.empty_trash
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_trash_item' do
    it 'deletes a specific item from trash' do
      allow(connection).to receive(:delete).with('/api/trash/items/my-repo/path/file.jar').and_return(ok_response)
      result = client.delete_trash_item(path: 'my-repo/path/file.jar')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#restore_trash_item' do
    it 'restores an item from trash' do
      allow(connection).to receive(:post)
        .with('/api/trash/restore/my-repo/file.jar', { target: 'my-repo/restored/' })
        .and_return(ok_response)
      result = client.restore_trash_item(path: 'my-repo/file.jar', target: 'my-repo/restored/')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#run_garbage_collection' do
    it 'triggers GC' do
      allow(connection).to receive(:post).with('/api/system/storage/gc').and_return(ok_response)
      result = client.run_garbage_collection
      expect(result[:status]).to eq(200)
    end
  end

  describe '#storage_info' do
    it 'fetches storage info' do
      allow(connection).to receive(:get).with('/api/storageinfo').and_return(ok_response)
      result = client.storage_info
      expect(result[:status]).to eq(200)
    end
  end
end
