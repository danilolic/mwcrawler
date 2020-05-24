# frozen_string_literal: true

RSpec.describe Mwcrawler::Crawler do
  it '#semester returns the current semester' do
    VCR.use_cassette('graduacao_default') do
      expect(subject.semester).to eq('2018/2')
    end
  end

  describe '#find_course' do
    it 'returns a Course object' do
      VCR.use_cassette('course_automatos') do
        expect(subject.find_course(116882)).to be_kind_of Mwcrawler::Course
      end
    end
  end
end
