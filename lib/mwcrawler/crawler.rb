module Mwcrawler
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
      Classes.scrap(1)
    when 2
      Classes.scrap(2)
    when 3
      Classes.scrap(3)
    when 4
      Classes.scrap(4)
    when 5
      Courses.scrap(1)
    when 6
      Courses.scrap(2)
    when 7
      Courses.scrap(3)
    when 8
      Courses.scrap(4)
    when 9
      Departments.scrap(1)
    when 10
      Departments.scrap(2)
    when 11
      Departments.scrap(3)
    when 12
      Departments.scrap(4)
    end
  end
end
