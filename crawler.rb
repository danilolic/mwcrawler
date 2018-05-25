require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'


# Lista os campi
# 1 - Darcy Ribeiro
# 2 - Planaltina
# 3 - Ceilândia
# 4 - Gama

def format_hour(schedules, row)
	while schedules.size != 0 do
		schedule = []
		schedule << schedules.slice!(0)
		schedule << schedules.slice!(0)
		schedule << schedules.slice!(0)
		# RETIRANDO LIXO
		schedules.slice!(0)
		# LOCAL
		schedule << schedules.slice!(0)
		row << schedule
	end
end

def format_teachers(teachers)
	if teachers.size == 0
		teachers = ["A Designar"]
	end
	teachers
end

def crawler(id_campus, file_name)
  # CADA TURMA SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODAS AS TURMAS
	@rows = []

  # LISTA DE DEPARTAMENTOS (inicialmente vazia)
	dep_links = []

  # LISTA DE MATÉRIAS (inicialmente vazia)
	course_links = []

  # DOMÍNIO
	site = 'https://matriculaweb.unb.br/graduacao/'
  # CAMPUS URI
	campus_uri = 'oferta_dep.aspx?cod='

  url = site + campus_uri + id_campus.to_s
  page = Nokogiri::HTML(open(url))
  dep_links = page.css('#datatable tbody tr td:nth-child(3) a')
                  .map { |link| link['href'] }


  # ITERA SOBRE TODOS OS DEPARTAMENTOS PEGANDO TODAS AS MATÉRIAS
	dep_links.each do |dep_link|
	  url = site + dep_link
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
	  url = site + course_link
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
			format_hour(schedules, row[:schedules])

			# PROFESSORES
			teachers = page.css('.tabela-oferta')[i]
										 .css('tr td:nth-child(5) td')
										 .map { |item| item.text }

	    row[:teachers] = []
			row[:teachers] = format_teachers(teachers)

	    @rows << row
	    class_count = class_count + 1
	    classes = class_count
	    puts "Total de turmas: #{classes}"
	  end
	end

  # ESCREVE O JSON
	File.open(file_name, 'w+') do |f|
    f.write @rows.to_json
	end
end

def menu
	puts 'Esolha o número do Campus que deseja fazer o Crawler'
	puts 'Lista dos campi'
	puts '1 - Darcy Ribeiro'
	puts '2 - Planaltina'
	puts '3 - Ceilândia'
	puts '4 - Gama'

	a = gets.to_i

	case a
	when 1
    crawler(1, "darcy.json")
	when 2
    crawler(2, "planaltina.json")
	when 3
    crawler(3, "ceilandia.json")
	when 4
    crawler(4, "gama.json")
	else
	  system "clear" or system "cls"
	  menu
	end
end

menu