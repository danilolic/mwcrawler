# frozen_string_literal: true

module Mwcrawler
  # Scraps Subjects by department
  module Subjects
    def self.scrap(department_or_id, options)
      if options[:by_id]
        subject_by_id(department_or_id)
      elsif options[:by_department]
        subject_by_department(department_or_id)
      else
        raise ArgumentError, 'second argument not specified. You can find a subject by department code or id'
      end
    end

    private

    def self.subject_by_department(department)
      page = Helpers.set_crawler(department, 'graduacao/oferta_dis.aspx?cod=', exact: true)
      scrap_row(department, page)
    end

    def self.subject_by_id(id)
      page = Helpers.set_crawler(id, 'graduacao/oferta_dados.aspx?cod=', exact: true)
      row_init_by_id(page)
    end

    def self.row_init_by_id(page)
      { code: page.css('#datatable')[0].css('tr:nth-child(2) td').text.to_i,
        name: page.css('#datatable')[0].css('tr:nth-child(3) td').text,
        department: page.css('#datatable tr:first-child a').first['href'].scan(/\d+/)[0].to_i,
        level: 'graduação' }
    end

    def self.scrap_row(dep_code, page)
      subjects = []
      length = page.css('#datatable tr td:nth-child(1)').count
      length.times do |i|
        subjects << row_init_by_department(page, dep_code, i)
      end
      subjects
    end

    def self.row_init_by_department(page, dep_code, index)
      { code: page.css('#datatable tr td:nth-child(1)').map(&:text)[index].to_i,
        name: page.css('#datatable tr td:nth-child(2)').map(&:text)[index],
        department: dep_code.to_i,
        level: 'graduação' }
    end
  end
end
