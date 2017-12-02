require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'erb'
require 'pry'


# Lista os campi
# 1 - Darcy Ribeiro
# 2 - Planaltina
# 3 - Ceilândia muita treta
# 4 - Gama

def crawler(id_campus, file_name)
	# Cada Turma será uma linha, então rows é o conjunto de todasa as turmas
	@rows = []

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
	    row = {}
	    row[:department] = department
	    row[:code] = code
	    row[:course] = course
	    row[:credits] = credits
	    row[:name] = cl
	    # FORMATA HORÁRIOS
	    schedules = page.css('.tabela-oferta')[i].css('tr td:nth-child(4) table tr:first-child td').map { |item| item.text }
	    row[:schedules] = []
	    while schedules.size != 0 do
	    	schedule = []
	    	schedule << schedules.slice!(0)
	    	schedule << schedules.slice!(0)
	    	schedule << schedules.slice!(0)
	    	row[:schedules] << schedule.join(' ') 
	    end
	    # FORMATA PROFESSORES
	    teachers = page.css('.tabela-oferta')[i].css('tr td:nth-child(5) td').map { |item| item.text }
	    row[:teachers] = []
	    teacher = {}
	    while teachers.size != 0 do
	    	teacher[:name] = teachers.slice!(0)
	    	row[:teachers] << teacher
	    end
	    
	    @rows << row
	    class_count = class_count + 1
	    classes = class_count
	    puts "Total de turmas: #{classes}"
	  end
	end
	# render template
	template = File.read('./template.html.erb')
	result = ERB.new(template).result(binding)

	# write result to file
	File.open(file_name, 'w+') do |f|
	  f.write result
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
	  crawler(1, "darcy_crawler.html")
	when 2
	  crawler(2, "planaltina_crawler.html")
	when 3
	  crawler(3, "ceilandia_crawler.html")
	when 4
	  crawler(4, "gama_crawler.html")
	else
	  system "clear" or system "cls"
	  menu
	end
end

menu