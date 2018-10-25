RSpec.describe Mwcrawler::Classes do
  Mwcrawler::Campuses.all.each do |campus, _campus_id|
    context "Classes campus: #{campus}" do
      before :all do
        VCR.use_cassette("classes_#{campus}") do
          @classes = Mwcrawler::Crawler.new.classes(campus)
        end
      end

      it 'crawls classes' do
        expect(@classes).to be_a_kind_of Array
      end
    end
  end
end
