# frozen_string_literal: true

require_relative 'jfrog/version'
require_relative 'jfrog/artifactory'

module Legion
  module Extensions
    module Jfrog
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
