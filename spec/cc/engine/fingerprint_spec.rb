# frozen_string_literal: true

require 'cc/engine/fingerprint'

RSpec.describe CC::Engine::Fingerprint do
  let(:linter) { 'LineLength' }
  let(:message) { 'This is a test' }
  let(:path) { 'hello_world.haml' }

  subject(:fingerprint) { described_class.new(path, linter, message) }

  describe '#to_s' do
    subject { fingerprint.to_s }

    it { is_expected.to eq('986165e0263588cb938b1b9ec1f05171') }

    context "when the linter isn't overridable" do
      let(:linter) { 'AltText' }

      it { is_expected.to be_nil }
    end
  end
end
