RSpec.describe Mwcrawler do
  it "has a version number" do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  [1, 2, 3, 4].each do |option|
    it "crawls classes" do
      classes = Mwcrawler::Crawler.new.start(option)
      expect(classes).to be_a_kind_of Array
    end
  end

  [5, 6, 7, 8].each do |option|
    it "crawls courses" do
      courses = Mwcrawler::Crawler.new.start(option)
      expect(courses.first.keys).to include("curriculums", "type", "code", "name", "shift")
    end
  end

  describe "Departments" do
    [9, 10, 11, 12].each do |option|
      subject(:department) { Mwcrawler::Crawler.new.start(option).first }

      it "has the correct keys" do
        expect(department.keys).to include("code", "acronym", "name")
      end

      it { expect(department["code"]).to be_a_kind_of String }
      it { expect(department["acronym"]).to be_a_kind_of String }
      it { expect(department["name"]).to be_a_kind_of String }
    end
  end
end
