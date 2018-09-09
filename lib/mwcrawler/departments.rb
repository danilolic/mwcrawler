module Mwcrawler
  module Departments
    def self.scrap(campus)
      # CADA DEPARTAMENTO SERA UMA LINHA, ENTAO rows E O CONJUNTO DE TODOS OS DEPARTAMENTOS
      rows = []

      page = Helpers.set_crawler(campus, 'graduacao/oferta_dep.aspx?cod=')
      departments = page.css('#datatable tr td').map(&:text)

      until departments.empty?
        row = {}
        row['code'] = departments.shift
        row['acronym'] = departments.shift
        row['name'] = departments.shift
        rows << row
      end

      rows
    end
  end
end
