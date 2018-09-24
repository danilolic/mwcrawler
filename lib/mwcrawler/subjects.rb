module Mwcrawler
  # Scraps Subjects by department
  module Subjects
    def self.scrap(campus)
      page = Helpers.set_crawler(campus, 'graduacao/oferta_dep.aspx?cod=')
      dep_links = department_links(page)
      dep_codes = department_codes(page)

      rows = []

      dep_links.each_with_index do |link, index|
        page = Nokogiri::HTML(URI.open(SITE + 'graduacao/' + link))
        rows << scrap_row(dep_codes[index], page)
      end
      rows.flatten!
    end

    private_class_method def self.scrap_row(dep_code, page)
      subjects = []
      length = page.css('#datatable tr td:nth-child(1)').count
      length.times do |i|
        subjects << subject_row_init(page, dep_code, i)
      end
      subjects
    end

    private_class_method def self.subject_row_init(page, department, index)
      { code: page.css('#datatable tr td:nth-child(1)').map(&:text)[index],
        name: page.css('#datatable tr td:nth-child(2)').map(&:text)[index],
        department: department,
        level: 'graduação' }
    end

    private_class_method def self.department_links(page)
      page.css('#datatable tr td:nth-child(3) a').map { |link| link['href'] }
    end

    private_class_method def self.department_codes(page)
      page.css('#datatable tr td:nth-child(1)').map(&:text)
    end
  end
end
