# frozen_string_literal: true

module Mwcrawler
  # Scraps curriculums by course code
  module Curriculum
    def self.scrap(code)
      rows = []
      page = Helpers.set_crawler(code, 'graduacao/curso_dados.aspx?cod=', exact: true)
      curriculums = page.css('.table-responsive h4').map { |item| item.children[0].text }
      page.css('.table-responsive .table').each do |table|
        rows << scrap_row(curriculums.shift, table)
      end
      rows
    end

    private_class_method def self.scrap_row(curriculum_name, table)
      row = {}
      row['name'] = curriculum_name
      row['degree'] = table.css('tr:first td').text
      row['semester_max'] = table.css('tr:nth-child(2) td').text
      row['semester_min'] = table.css('tr:nth-child(3) td').text
      row['credits'] = table.css('tr:nth-child(4) td').text
      row
    end
  end
end
