# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jfrog do
  it 'has a version number' do
    expect(Legion::Extensions::Jfrog::VERSION).not_to be_nil
  end

  it 'defines the Artifactory sub-module' do
    expect(described_class.const_defined?(:Artifactory)).to be true
  end
end
