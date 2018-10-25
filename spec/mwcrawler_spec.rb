RSpec.describe Mwcrawler do
  it 'has a version number' do
    expect(Mwcrawler::VERSION).not_to be nil
  end

  describe 'Classes scrap' do
    [116].each do |department_code|
      context "Classes department: #{department_code}" do
        let(:first_class) { @classes.first }

        before :all do
          VCR.use_cassette("classes_#{department_code}") do
            @classes = Mwcrawler::Crawler.new.classes(department_code)
          end
        end

        it { expect(@classes).to be_a_kind_of Array }
        it { expect(@classes).to_not be_empty }

        it 'has the correct keys' do
          expect(first_class.keys).to include(:department, :code, :course_code, :name, :schedules, :teachers, :credits)
        end

        it { expect(first_class[:code]).to be_a_kind_of Integer }
        it { expect(first_class[:course_code]).to be_a_kind_of Integer }
        it { expect(first_class[:schedules]).to be_a_kind_of Array }
        it { expect(first_class[:teachers]).to be_a_kind_of Array }
        it { expect(first_class[:credits]).to be_a_kind_of Hash }
        it { expect(first_class[:credits].keys).to include(:theory, :practical, :extension, :study) }

        %i[theory practical extension study].each do |credit_type|
          it { expect(first_class[:credits][credit_type]).to be_a_kind_of Integer }
        end
      end
    end
  end

  describe 'Courses scrap' do
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

  describe 'Departments scrap' do
    Mwcrawler::Campuses::CAMPUSES.each do |campus, _campus_id|
      context "Departments campus: #{campus}", :vcr do
        subject(:department) { @departments.first }

        before :all do
          VCR.use_cassette("departments_#{campus}") do
            @departments = Mwcrawler::Crawler.new.departments(campus)
          end
        end

        it 'has the correct keys' do
          expect(department.keys).to include('code', 'acronym', 'name')
        end

        it { expect(department['code']).to be_a_kind_of String }
        it { expect(department['acronym']).to be_a_kind_of String }
        it { expect(department['name']).to be_a_kind_of String }
      end
    end
  end

  describe 'Campuses id' do
    context 'when campus is invalid' do
      subject(:campus_id) { Mwcrawler::Campuses.id(:invalid_campus) }

      it { expect { campus_id }.to raise_error ArgumentError, /Campus: #{:invalid_campus} not in:/ }
    end
  end
end
