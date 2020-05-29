# frozen_string_literal: true

RSpec.describe Mwcrawler::Subjects do
  context 'Subjects by department: CIC' do
    before :all do
      VCR.use_cassette('subjects/subjects_cic') do
        @subjects = Mwcrawler::Crawler.new.subjects('116', by_department: true)
      end
    end

    it { expect(@subjects).to be_a_kind_of Array }

    it { expect(@subjects).not_to be nil }

    it { expect(@subjects.first.keys).to include(:code, :department, :name, :level) }

    it { expect(@subjects.first).to include(code: be_integer) }

    it { expect(@subjects.first).to include(code: be_nonzero) }

    it { expect(@subjects.first).to include(department: be_integer) }

    it { expect(@subjects.first).to include(department: be_nonzero) }
  end

  context 'crawls subject by id' do
    before :all do
      VCR.use_cassette('subjects/subject_116441') do
        @subject = Mwcrawler::Crawler.new.subjects('116441', by_id: true)
      end
    end

    it { expect(@subject).to be_a_kind_of Hash }

    it { expect(@subject.keys).to include(:code, :department, :name, :level) }

    it { expect(@subject).to include(code: be_integer) }

    it { expect(@subject).to include(code: be_nonzero) }

    it { expect(@subject).to include(department: be_integer) }

    it { expect(@subject).to include(department: be_nonzero) }
  end
end
