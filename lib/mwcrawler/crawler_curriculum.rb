def crawler_curriculum(code)
  rows = []
  page = set_crawler(code,'graduacao/curso_dados.aspx?cod=')
  curriculums = page.css('.table-responsive h4').map { |item| item.children[0].text }
  page.css('.table-responsive .table').each do |table|
    row = {}
    row['name'] = curriculums.shift
    row['degree'] = table.css('tr:first td').text
    row['semester_max'] = table.css('tr:nth-child(2) td').text
    row['semester_min'] = table.css('tr:nth-child(3) td').text
    row['credits'] = table.css('tr:nth-child(4) td').text
    rows << row
  end
  rows
end
