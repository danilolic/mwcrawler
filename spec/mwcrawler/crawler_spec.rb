RSpec.describe Mwcrawler::Crawler do
  it '#semester returns the current semester' do
    VCR.use_cassette("graduacao_default") do
      crawler = Mwcrawler::Crawler.new
      expect(crawler.semester).to eq('2018/2')
    end
  end
end