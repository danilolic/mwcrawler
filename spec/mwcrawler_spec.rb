RSpec.describe Mwcrawler do
  it "has a version number" do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  describe "Classes scrap" do
    [1, 2, 3, 4].each do |option|
      context "Classes option: #{option}" do
        before :all do
          @classes = Mwcrawler::Crawler.new.start(option)
        end

        it "crawls classes" do
          expect(@classes).to be_a_kind_of Array
        end
      end
    end
  end

  describe "Courses scrap" do
    [[5, 99], [6, 5], [7, 6], [8, 6]].each do |option, expected_course_count|
      context "Courses option: #{option}" do
        let(:course) { @courses.first }

        before :all do
          @courses = Mwcrawler::Crawler.new.start(option)
        end

        it "has the correct keys" do
          expect(course.keys).to include("curriculums", "type", "code", "name", "shift")
        end

        it { expect(@courses.size).to be expected_course_count }
      end
    end
  end

  describe "Departments scrap" do
    [9, 10, 11, 12].each do |option|
      context "Departments option: #{option}" do
        subject(:department) { @departments.first }

        before :all do
          @departments = Mwcrawler::Crawler.new.start(option)
        end

        it "has the correct keys" do
          expect(department.keys).to include("code", "acronym", "name")
        end

        it { expect(department["code"]).to be_a_kind_of String }
        it { expect(department["acronym"]).to be_a_kind_of String }
        it { expect(department["name"]).to be_a_kind_of String }
      end
    end
  end
end
