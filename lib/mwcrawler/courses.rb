# frozen_string_literal: true

require 'mwcrawler/curriculum'

module Mwcrawler
  # Scraps Courses by campus
  module Courses
    def self.scrap(campus)
      page = Helpers.set_crawler(campus, 'graduacao/curso_rel.aspx?cod=')
      courses = page.css('#datatable tr td').map(&:text)

      # CADA CURSO SERA UMA LINHA, ENTAO rows E O CONJUNTO DE TODAS AS TURMAS
      rows = []
      rows << scrap_row(courses) until courses.empty?
      Helpers.log "Total de cursos: #{rows.count}"

      rows
    end

    private

    def self.scrap_row(courses)
      row = {}
      row['type'] = courses.shift
      row['code'] = courses.shift
      row['name'] = courses.shift
      row['shift'] = courses.shift
      row['curriculums'] = Curriculum.scrap(row['code'])
      row
    end
  end
end
