RSpec.describe Mwcrawler::Course do
  let(:course) { Mwcrawler::Crawler.new.find_course(116882) }

  it '#bibliography returns the best book' do
    VCR.use_cassette('course_automatos') do
      expect(course.bibliography).to include('Introduction to the Theory of Computation')
    end
  end

  it '#course_summary returns the subject' do
    VCR.use_cassette('course_automatos') do
      expect(course.course_summary).to include('Decidibilidade')
    end
  end

  it '#course_program returns the program' do
    VCR.use_cassette('course_automatos') do
      expect(course.course_program).to include('A máquina de Turing')
    end
  end
end