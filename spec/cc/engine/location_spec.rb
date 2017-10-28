# frozen_string_literal: true

require 'cc/engine/location'

RSpec.describe CC::Engine::Location do
  let(:line) { 42 }
  let(:path) { '/path/to/hello_world.haml' }

  subject(:location) { described_class.new(line: line, path: path) }

  describe '#to_h' do
    subject { location.to_h }

    it { is_expected.to eq(path: '/path/to/hello_world.haml', lines: { begin: 42, end: 42 }) }
  end

  describe '#to_json' do
    subject { location.to_json }

    it { is_expected.to eq('{"path":"/path/to/hello_world.haml","lines":{"begin":42,"end":42}}') }
  end
end
