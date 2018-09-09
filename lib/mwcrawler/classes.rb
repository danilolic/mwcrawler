module Mwcrawler
  # Scraps Classes by campus
  module Classes
    def self.scrap(campus)
      page = Helpers.set_crawler(campus, 'graduacao/oferta_dep.aspx?cod=')
      dep_links = page.css('#datatable tbody tr td:nth-child(3) a')
                      .map { |link| link['href'] }

      course_links = scrap_course_links(dep_links, page)

      # CADA TURMA SERA UMA LINHA, ENTAO rows E O CONJUNTO DE TODAS AS TURMAS
      rows = []
      course_links.flatten!
      # ITERA SOBRE TODAS AS MATERIAS PEGANDO TODAS AS TURMAS
      course_links.each do |course_link|
        rows += scrap_classes(course_link)
      end
      rows
    end

    private_class_method def self.scrap_course_links(dep_links, page)
      # LISTA DE MATERIAS (inicialmente vazia)
      course_links = []
      # ITERA SOBRE TODOS OS DEPARTAMENTOS PEGANDO TODAS AS MATERIAS
      dep_links.each do |dep_link|
        page = Nokogiri::HTML(open(SITE + dep_link))
        course_links << page.css('#datatable tr td:nth-child(2) a')
                            .map { |link| link['href'] }
      end
      course_links
    end
    private_class_method def self.scrap_classes(course_link)
      rows = []

      page = Nokogiri::HTML(open(SITE + course_link))
      page_classes = page.css('.tabela-oferta .turma').map(&:text)

      page_classes.each_with_index do |cl, i|
        row_init = class_row_init(page, cl)
        rows << scrap_row(row_init, page, i)
        Helpers.log "Total de turmas: #{rows.size}"
      end
      rows
    end
    private_class_method def self.class_row_init(page, name)
      { department: page.css('#datatable tr:first-child a').text,
        code:  page.css('#datatable')[0].css('tr:nth-child(2) td').text,
        course: page.css('#datatable')[0].css('tr:nth-child(3) td').text,
        credits: page.css('#datatable')[0].css('tr:nth-child(4) td').text,
        name: name }
    end

    private_class_method def self.scrap_row(row_init, page, count)
      row = row_init
      row.merge(scrap_vacancies(page, count))
      # HORARIOS
      row[:schedules] = scrap_schedules(page, count)
      # PROFESSORES
      row[:teachers] = scrap_teachers(page, count)
      row
    end

    private_class_method def self.scrap_schedules(page, count)
      schedules = page.css('.tabela-oferta')[count]
                  .css('tr td:nth-child(4) .table')
                  .css('td').map(&:text)

      Helpers.format_hours(schedules)
    end

    private_class_method def self.scrap_teachers(page, count)
      teachers = page.css('.tabela-oferta')[count]
                 .css('tr td:nth-child(5) td')
                     .map(&:text)

      Helpers.format_teachers(teachers)
    end

    private_class_method def self.scrap_vacancies(page, count)
      { vacancies_total: scrap_vacancy(1, page, count),
        vacancies_occupied: scrap_vacancy(2, page, count),
        vacancies_free: scrap_vacancy(3, page, count) }
    end

    private_class_method def self.scrap_vacancy(vacancy_row, page, count)
      page.css('.tabela-oferta')[count]
          .css(".tabela-vagas tr:nth-child(#{vacancy_row}) td:nth-child(3)").text
    end
  end
end
