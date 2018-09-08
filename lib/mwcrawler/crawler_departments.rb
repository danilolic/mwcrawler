def crawler_departments(id_campus, file_name)
  # CADA DEPARTAMENTO SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODOS OS DEPARTAMENTOS
  rows = []

	page = set_crawler(id_campus,'graduacao/oferta_dep.aspx?cod=')
  departments = page.css('#datatable tr td').map { |item| item.text }

  while !departments.empty?
    row = {}
    row['code'] = departments.shift
    row['acronym'] = departments.shift
    row['name'] = departments.shift
    rows << row
  end

  write_json(file_name, rows)
end
