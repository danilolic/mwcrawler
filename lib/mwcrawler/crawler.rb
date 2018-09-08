# DOMÍNIO
SITE = 'https://matriculaweb.unb.br/'

def menu(option)
   # Escolha uma opção:
   # 1 - Pegar as turmas do Darcy Ribeiro
   # 2 - Pegar as turmas de Planaltina
   # 3 - Pegar as turmas da Ceilândia
   # 4 - Pegar as turmas do Gama
   # -------------------------------------------
   # 5 - Pegar os cursos do Darcy Ribeiro
   # 6 - Pegar os cursos de Planaltina
   # 7 - Pegar os cursos da Ceilândia
   # 8 - Pegar os cursos do Gama
   # -------------------------------------------
   # 9 - Pegar os departamentos do Darcy Ribeiro
   # 10 - Pegar os departamentos de Planaltina
   # 11 - Pegar os departamentos da Ceilândia
   # 12 - Pegar os departamentos do Gama


  case option
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
