require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

require './crawler_classes'
require './crawler_courses'

# DOMÍNIO
SITE = 'https://matriculaweb.unb.br/graduacao/'

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