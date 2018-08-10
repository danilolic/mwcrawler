require './helpers'

def crawler_courses(id_campus, file_name)
	rows = []
	page = set_crawler(id_campus,'curso_rel.aspx?cod=')
	courses = page.css('#datatable tr td').map { |item| item.text }

	while !courses.empty? do
		row = {}
		row['type'] = courses.slice!(0)
		row['code'] = courses.slice!(0)
		row['name'] = courses.slice!(0)
		row['shift'] = courses.slice!(0)
		rows << row
	end

	puts "Total de cursos: #{rows.count}"

	write_json(file_name, rows)
end