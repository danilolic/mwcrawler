module Mwcrawler
  # Scraps Classes by campus
  module Classes
    def self.scrap(department_code)
      courses_links = scrap_courses_links(department_code)
      rows = []
      courses_links.each do |course_link|
        rows += scrap_classes(course_link)
      end
      rows
    end

    private_class_method def self.scrap_courses_links(department_code)
      page = Helpers.set_crawler(department_code, 'graduacao/oferta_dis.aspx?cod=', exact: true)
      page.css('#datatable tr td:nth-child(2) a')
          .map { |link| link['href'] }
    end

    private_class_method def self.scrap_classes(course_link)
      rows = []

      page = Helpers.set_crawler(course_link, 'graduacao/', exact: true)
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
        code:  page.css('#datatable')[0].css('tr:nth-child(2) td').text.to_i,
        course_code: scrap_course_code(page),
        credits: scrap_credit_hash(page),
        name: name }
    end

    private_class_method def self.scrap_course_code(page)
      course_uri = page.css('#datatable')[0].css('tr:nth-child(3) td a').first['href']
      Helpers.uri_query_params(course_uri)['cod'].to_i
    end

    private_class_method def self.scrap_credit_hash(page)
      credit_string = page.css('#datatable')[0].css('tr:nth-child(4) td').text
      credits = credit_string.split('-').map(&:to_i)
      { theory: credits[0], practical: credits[1], extension: credits[2], study: credits[3] }
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
