# frozen_string_literal: true

RSpec.describe Mwcrawler do
  it 'has a version number' do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  describe 'Campuses id' do
    context 'when campus is invalid' do
      subject(:campus_id) { Mwcrawler::Campuses.id(:invalid_campus) }

      it { expect { campus_id }.to raise_error ArgumentError, /Campus: #{:invalid_campus} not in:/ }
    end
  end
end
