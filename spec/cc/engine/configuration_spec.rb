# frozen_string_literal: true

require 'spec_helper'
require 'cc/engine/configuration'

RSpec.describe CC::Engine::Configuration do
  subject(:config) { described_class.new(attrs) }

  context 'when the linters are configured without a HamlLint prefix' do
    let(:attrs) do
      {
        'checks' => {
          'AltText' => {
            'enabled' => true
          }
        }
      }
    end

    describe '#to_linter_config' do
      subject { config.to_linter_config }

      it 'obeys the configuration for the linter' do
        expect(subject.for_linter(HamlLint::Linter::AltText)['enabled']).to eq(true)
      end
    end
  end

  context 'when the linters are configured with a HamlLint prefix' do
    let(:attrs) do
      {
        'checks' => {
          'HamlLint/AltText' => {
            'enabled' => true
          }
        }
      }
    end

    describe '#to_linter_config' do
      subject { config.to_linter_config }

      it 'obeys the configuration for the linter' do
        expect(subject.for_linter(HamlLint::Linter::AltText)['enabled']).to eq(true)
      end
    end
  end
end
