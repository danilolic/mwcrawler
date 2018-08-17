require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

require './crawler_classes'
require './crawler_courses'
require './crawler_departments'

# DOMÍNIO
SITE = 'https://matriculaweb.unb.br/'

def menu
  puts 'Escolha uma opção:'
  puts '1 - Pegar as turmas do Darcy Ribeiro'
  puts '2 - Pegar as turmas de Planaltina'
  puts '3 - Pegar as turmas da Ceilândia'
  puts '4 - Pegar as turmas do Gama'
  puts '-------------------------------------------'
  puts '5 - Pegar os cursos do Darcy Ribeiro'
  puts '6 - Pegar os cursos de Planaltina'
  puts '7 - Pegar os cursos da Ceilândia'
  puts '8 - Pegar os cursos do Gama'
  puts '-------------------------------------------'
  puts '9 - Pegar os departamentos do Darcy Ribeiro'
  puts '10 - Pegar os departamentos de Planaltina'
  puts '11 - Pegar os departamentos da Ceilândia'
  puts '12 - Pegar os departamentos do Gama'

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
  when 9
    crawler_departments(1, 'darcy_departments.json')
  when 10
    crawler_departments(2, 'planaltina_departments.json')
  when 11
    crawler_departments(3, 'ceilandia_departments.json')
  when 12
    crawler_departments(4, 'gama_departments.json')
  else
    system 'clear' or system 'cls'
    menu
  end
end

menu