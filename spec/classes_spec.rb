RSpec.describe Mwcrawler::Classes do
  Mwcrawler::Campuses::CAMPUSES.each do |campus, _campus_id|
    context "Classes campus: #{campus}" do
      before :all do
        VCR.use_cassette("classes/#{campus}") do
          @classes = Mwcrawler::Crawler.new.classes(campus)
        end
      end

      it 'crawls classes' do
        expect(@classes).to be_a_kind_of Array
      end
    end
  end
end
