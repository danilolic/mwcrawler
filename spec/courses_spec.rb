RSpec.describe Mwcrawler::Courses do
  [[:darcy_ribeiro, 99], [:planaltina, 5], [:ceilandia, 6], [:gama, 6]].each do |campus, expected_course_count|
    context "Courses campus: #{campus}", :vcr do
      let(:course) { @courses.first }

      before :all do
        VCR.use_cassette("courses_#{campus}") do
          @courses = Mwcrawler::Crawler.new.courses(campus)
        end
      end

      it 'has the correct keys' do
        expect(course.keys).to include('curriculums', 'type', 'code', 'name', 'shift')
      end

      it { expect(@courses.size).to be expected_course_count }
    end
  end
end
