# frozen_string_literal: true

RSpec.describe Mwcrawler::Classes do
  [116].each do |department_code|
    context "Classes department: #{department_code}" do
      let(:first_class) { @classes.first }
      before :all do
        VCR.use_cassette("classes/#{department_code}") do
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
