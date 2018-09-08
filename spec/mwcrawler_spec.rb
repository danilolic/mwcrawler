RSpec.describe Mwcrawler do
  it "has a version number" do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  [1, 2, 3].each do |option|
    it "crawls classes" do
      classes = Mwcrawler::Crawler.new.start(option)
      expect(classes).to be_a_kind_of Array
    end
  end
end
