require './helpers'
require './crawler_curriculum'

def crawler_courses(id_campus, file_name)
	# CADA CURSO SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODAS AS TURMAS
	rows = []

	page = set_crawler(id_campus,'graduacao/curso_rel.aspx?cod=')
	courses = page.css('#datatable tr td').map { |item| item.text }

	while !courses.empty? do
		row = {}
		row['curriculums'] = []
		row['type'] = courses.shift
		row['code'] = courses.shift
		row['name'] = courses.shift
		row['shift'] = courses.shift
		row['curriculums'] = crawler_curriculum(row['code'])
		rows << row
	end

	puts "Total de cursos: #{rows.count}"

	write_json(file_name, rows)
end