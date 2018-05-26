require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

# DOMÍNIO
SITE = 'https://matriculaweb.unb.br/graduacao/'

def format_hours(schedules, row)
	while schedules.size != 0 do
		schedule = []
		schedule << schedules.slice!(0) # DIA
		schedule << schedules.slice!(0) # INÍCIO
		schedule << schedules.slice!(0) # FIM
		schedules.slice!(0) # RETIRANDO LIXO
		schedule << schedules.slice!(0) # LOCAL
		row << schedule
	end
end

def format_teachers(teachers)
	if teachers.size == 0
		teachers = ['A Designar']
	end
	teachers
end

# DEPARTAMENTO OU CURSO
def set_crawler(id_campus, mode)
	search_mode = mode

  url = SITE + search_mode + id_campus.to_s
  page = Nokogiri::HTML(open(url))
end

def crawler_classes(id_campus, file_name)
	# CADA TURMA SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODAS AS TURMAS
	rows = []

	# LISTA DE DEPARTAMENTOS (inicialmente vazia)
	dep_links = []

	# LISTA DE MATÉRIAS (inicialmente vazia)
	course_links = []

	page = set_crawler(id_campus, 'oferta_dep.aspx?cod=')

  dep_links = page.css('#datatable tbody tr td:nth-child(3) a')
                  .map { |link| link['href'] }


  # ITERA SOBRE TODOS OS DEPARTAMENTOS PEGANDO TODAS AS MATÉRIAS
	dep_links.each do |dep_link|
	  url = SITE + dep_link
	  page = Nokogiri::HTML(open(url))
    course_links << page.css('#datatable tr td:nth-child(2) a')
                        .map { |link| link['href'] }
	end
	course_links.flatten!
  # CONTADORES
	classes = 0
	class_count = 0
  # ITERA SOBRE TODAS AS MATÉRIAS PEGANDO TODAS AS TURNAS
	course_links.each do |course_link|
	  url = SITE + course_link
	  page = Nokogiri::HTML(open(url))
	  page_classes = page.css('.tabela-oferta .turma').map { |item| item.text}
	  department 	 = page.css('#datatable tr:first-child a').text
	  code 				 = page.css('#datatable')[0].css('tr:nth-child(2) td').text
	  course  		 = page.css('#datatable')[0].css('tr:nth-child(3) td').text
		credits 		 = page.css('#datatable')[0].css('tr:nth-child(4) td').text

	  page_classes.each_with_index do |cl, i|
	    row = {}
	    row[:department] = department
	    row[:code] = code
	    row[:course] = course
	    row[:credits] = credits
			row[:name] = cl
			row[:vacancies_total] = page.css('.tabela-oferta')[i]
																	.css('.tabela-vagas tr:nth-child(1) td:nth-child(3)').text
			row[:vacancies_occupied] = page.css('.tabela-oferta')[i]
																		 .css('.tabela-vagas tr:nth-child(2) td:nth-child(3)').text

			row[:vacancies_free] = page.css('.tabela-oferta')[i]
																 .css('.tabela-vagas tr:nth-child(3) td:nth-child(3)').text

	    # HORÁRIOS
			schedules = page.css('.tabela-oferta')[i]
											.css('tr td:nth-child(4) .table')
											.css('td').map { |item| item.text }

			row[:schedules] = []
			format_hours(schedules, row[:schedules])

			# PROFESSORES
			teachers = page.css('.tabela-oferta')[i]
										 .css('tr td:nth-child(5) td')
										 .map { |item| item.text }

	    row[:teachers] = []
			row[:teachers] = format_teachers(teachers)

	    rows << row
	    class_count = class_count + 1
	    classes = class_count
	    puts "Total de turmas: #{classes}"
	  end
	end

  # ESCREVE O JSON
	File.open(file_name, 'w+') do |f|
    f.write rows.to_json
	end
end

def crawler_courses(id_campus, file_name)
	page = set_crawler(id_campus,'curso_rel.aspx?cod=')
	courses = page.css('#datatable tr td:nth-child(3) a').map { |item| item.text}
	courses.uniq!
	puts "Total de cursos: #{courses.count}"
	# ESCREVE O JSON
	File.open(file_name, 'w+') do |f|
    f.write courses.to_json
	end
end

def menu
	puts 'Escolha uma opção:'
	puts '1 - Pega as turmas do Darcy Ribeiro'
	puts '2 - Pega as turmas de Planaltina'
	puts '3 - Pega as turmas de Ceilândia'
	puts '4 - Pega as turmas do Gama'
	puts '-------------------------------------------'
	puts '5 - Pega os cursos do Darcy Ribeiro'
	puts '6 - Pega os cursos do Planaltina'
	puts '7 - Pega os cursos do Ceilândia'
	puts '8 - Pega os cursos do Gama'

	a = gets.to_i

	case a
	when 1
    crawler_classes(1, 'darcy.json')
	when 2
    crawler_classes(2, 'planaltina.json')
	when 3
    crawler_classes(3, 'ceilandia.json')
	when 4
		crawler_classes(4, 'gama.json')
	when 5
		crawler_courses(1, 'darcy_courses.json')
	when 6
		crawler_courses(2, 'planaltina_courses.json')
	when 7
		crawler_courses(3, 'ceilandia_courses.json')
	when 8
		crawler_courses(4, 'gama_courses.json')
	else
	  system 'clear' or system 'cls'
	  menu
	end
end

menu