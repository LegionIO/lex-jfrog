# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog::Artifactory::Client do
  subject(:client) { described_class.new(host: 'https://example.jfrog.io/artifactory', token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(host: 'https://example.jfrog.io/artifactory', token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'sets the authorization header' do
    conn = client.client
    expect(conn.headers['Authorization']).to eq('Bearer test-token')
  end

  it 'includes Repositories runner' do
    expect(client).to respond_to(:create)
    expect(client).to respond_to(:list)
  end

  it 'includes Searches runner' do
    expect(client).to respond_to(:aql)
    expect(client).to respond_to(:artifact_search)
  end

  it 'includes Security runner' do
    expect(client).to respond_to(:get_user)
    expect(client).to respond_to(:list_permissions)
  end

  it 'includes Storage runner' do
    expect(client).to respond_to(:empty_trash)
    expect(client).to respond_to(:storage_info)
  end

  it 'includes ReleaseBundles runner' do
    expect(client).to respond_to(:list_bundles)
    expect(client).to respond_to(:get_version)
  end
end
