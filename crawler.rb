require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'
require 'pry'


# Lista os campi
# 1 - Darcy Ribeiro
# 2 - Planaltina
# 3 - Ceilândia muita treta
# 4 - Gama

def crawler(id_campus, file_name)
	# Cada Turma será uma linha, então rows é o conjunto de todasa as turmas
	rows = []

	# Lista de departamentos (inicialmente vazia)
	dep_links = []

	# Lista de matérias (inicialmente vazia)
	course_links = []

  # Domínio
	site = 'https://matriculaweb.unb.br/graduacao/'
	# Campus uri
	campus_uri = 'oferta_dep.aspx?cod='
  
  url = site + campus_uri + id_campus.to_s
  page = Nokogiri::HTML(open(url))
  dep_links = page.css('#datatable tbody tr td:nth-child(3) a').map { |link| link['href'] }
	

	# Itera sobre todos os departamentos pegando todas as matérias
	dep_links.each do |dep_link|
	  url = site + dep_link
	  page = Nokogiri::HTML(open(url))
	  course_links << page.css('#datatable tr td:nth-child(2) a').map { |link| link['href'] }
	end
	course_links.flatten!
	# Contadores
	classes = 0
	class_count = 0
	# Itera sobre todas as matérias pegando todas as turmas
	course_links.each do |course_link|
	  url = site + course_link
	  page = Nokogiri::HTML(open(url))
	  page_classes = page.css('.tabela-oferta .turma').map { |item| item.text}
	  department 	 = page.css('#datatable tr:first-child a').text
	  code 				 = page.css('#datatable')[0].css('tr:nth-child(2) td').text
	  course  		 = page.css('#datatable')[0].css('tr:nth-child(3) td').text
	  credits 		 = page.css('#datatable')[0].css('tr:nth-child(4) td').text
	  
	  page_classes.each_with_index do |cl, i|
	    row = []
	    row << department
	    row << code
	    row << course
	    row << credits
	    row << cl
	    # FORMATA HORÁRIOS
	    schedules = page.css('.tabela-oferta')[i].css('tr td:nth-child(4) table tr:first-child td').map { |item| item.text }
	    schdule = ""
	    while schedules.size != 0 do
	    	day = schedules.slice!(0)
	    	start_time = schedules.slice!(0)
	    	end_time = schedules.slice!(0)
	    	schdule = "#{schdule} #{day} #{start_time} #{end_time} \n" 
	    end
	    row << schdule
	    # FORMATA PROFESSORES
	    teachers = page.css('.tabela-oferta')[i].css('tr td:nth-child(5) td').map { |item| item.text }
	    row << teachers.join("\n")
	    rows << row
	    class_count = class_count + 1
	    classes = class_count
	    puts "Total de turmas: #{classes}"
	  end
	end
	# SALVA AS ROWS NA TABELA
	table = Terminal::Table.new :title => "Lista de todas as turmas do Matrícula Web", 
															:headings => ['Departamento', 'Código', 'Nome', 'Créditos', 'Turma', 'Horário', 'Professor'],
															:rows => rows,
															:style => {:all_separators => true, :border_x => "_", :border_i => "_"}

	# ESCREVE NO ARQUIVO
	File.open(file_name, 'w') { |file| file.write(table) }											
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
	  crawler(1, "darcy_crawler.txt")
	when 2
	  crawler(2, "planaltina_crawler.txt")
	when 3
	  crawler(3, "ceilandia_crawler.txt")
	when 4
	  crawler(4, "gama_crawler.txt")
	else
	  system "clear" or system "cls"
	  menu
	end
end

menu