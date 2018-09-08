RSpec.describe Mwcrawler do
  it "has a version number" do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  it "crawls" do
    Mwcrawler::Crawler.new.start(2)
  end
end
