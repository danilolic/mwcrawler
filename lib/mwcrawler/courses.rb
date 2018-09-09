require 'mwcrawler/curriculum'

module Mwcrawler
  module Courses
    def self.scrap(campus)
      # CADA CURSO SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODAS AS TURMAS
      rows = []

      page = Helpers.set_crawler(campus, 'graduacao/curso_rel.aspx?cod=')
      courses = page.css('#datatable tr td').map(&:text)

      until courses.empty?
        row = {}
        row['curriculums'] = []
        row['type'] = courses.shift
        row['code'] = courses.shift
        row['name'] = courses.shift
        row['shift'] = courses.shift
        row['curriculums'] = Curriculum.scrap(row['code'])
        rows << row
      end

      Helpers.log "Total de cursos: #{rows.count}"

      rows
    end
  end
end
