require 'mwcrawler/curriculum'

module Mwcrawler
	module Courses
		def self.scrap(id_campus, file_name)
			# CADA CURSO SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODAS AS TURMAS
			rows = []

			page = Helpers.set_crawler(id_campus,'graduacao/curso_rel.aspx?cod=')
			courses = page.css('#datatable tr td').map { |item| item.text }

			while !courses.empty? do
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

			# Helpers.write_json(file_name, rows)
			return rows
		end
	end
end
