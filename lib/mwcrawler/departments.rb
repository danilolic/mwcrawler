module Mwcrawler
  # Scraps Departments by campus
  module Departments
    def self.scrap(campus)
      page = Helpers.set_crawler(campus, 'graduacao/oferta_dep.aspx?cod=')
      departments = page.css('#datatable tr td').map(&:text)

      # CADA DEPARTAMENTO SERA UMA LINHA, ENTAO rows E O CONJUNTO DE TODOS OS DEPARTAMENTOS
      rows = []
      rows << scrap_row(departments) until departments.empty?
      rows
    end

    private_class_method def self.scrap_row(departments)
      row = {}
      row['code'] = departments.shift
      row['acronym'] = departments.shift
      row['name'] = departments.shift
      row
    end
  end
end
