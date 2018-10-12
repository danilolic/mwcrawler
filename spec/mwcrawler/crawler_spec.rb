RSpec.describe Mwcrawler::Crawler do
  it '#semester returns the current semester' do
    VCR.use_cassette("graduacao_default") do
      expect(subject.semester).to eq('2018/2')
    end
  end
end