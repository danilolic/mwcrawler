RSpec.describe Mwcrawler::Departments do
  Mwcrawler::Campuses.all.each do |campus, _campus_id|
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
