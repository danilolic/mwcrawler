module Mwcrawler
  # Scraps Subjects by department
  module Subjects
    def self.scrap(campus_or_id, by_id)
      if by_id
        subject(campus_or_id)
      else
        subjects(campus_or_id)
      end
    end

    private_class_method def self.subjects(campus)
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

    private_class_method def self.subject(id)
      page = Nokogiri::HTML(URI.open(SITE + 'graduacao/oferta_dados.aspx?cod=' + id.to_s))
      subject_row_init(page)
    end

    private_class_method def self.scrap_row(dep_code, page)
      subjects = []
      length = page.css('#datatable tr td:nth-child(1)').count
      length.times do |i|
        subjects << subjects_row_init(page, dep_code, i)
      end
      subjects
    end

    private_class_method def self.subjects_row_init(page, department, index)
      { code: page.css('#datatable tr td:nth-child(1)').map(&:text)[index],
        name: page.css('#datatable tr td:nth-child(2)').map(&:text)[index],
        department: department,
        level: 'graduação' }
    end

    private_class_method def self.subject_row_init(page)
      { code: page.css('#datatable')[0].css('tr:nth-child(2) td').text,
        name: page.css('#datatable')[0].css('tr:nth-child(3) td').text,
        department: page.css('#datatable tr:first-child a').first['href'].scan(/\d+/)[0],
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
