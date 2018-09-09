RSpec.describe Mwcrawler do
  it "has a version number" do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  describe "Classes scrap" do
    Mwcrawler::CAMPUSES.each do |campus, _campus_id|
      context "Classes campus: #{campus}" do
        before :all do
          @classes = Mwcrawler::Crawler.new.classes(campus)
        end

        it "crawls classes" do
          expect(@classes).to be_a_kind_of Array
        end
      end
    end
  end

  describe "Courses scrap" do
    [[:darcy_ribeiro, 99], [:planaltina, 5], [:ceilandia, 6], [:gama, 6]].each do |option, expected_course_count|
      context "Courses option: #{option}" do
        let(:course) { @courses.first }

        before :all do
          @courses = Mwcrawler::Crawler.new.courses(option)
        end

        it "has the correct keys" do
          expect(course.keys).to include("curriculums", "type", "code", "name", "shift")
        end

        it { expect(@courses.size).to be expected_course_count }
      end
    end
  end

  describe "Departments scrap" do
    Mwcrawler::CAMPUSES.each do |campus, _campus_id|
      context "Departments campus: #{campus}" do
        subject(:department) { @departments.first }

        before :all do
          @departments = Mwcrawler::Crawler.new.departments(campus)
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
