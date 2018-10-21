module Mwcrawler
  # Main api for crawling
  class Crawler
    include Mwcrawler

    def courses(campus = :darcy_ribeiro, options = { log: false })
      Options.init(options)
      Courses.scrap campus
    end

    def classes(campus = :darcy_ribeiro, options = { log: false })
      Options.init(options)
      Classes.scrap campus
    end

    def departments(campus = :darcy_ribeiro, options = { log: false })
      Options.init(options)
      Departments.scrap campus
    end

    def semester
      page = Helpers.set_crawler(nil, 'graduacao/default.aspx', exact: true)
      page.css("a[title='Período Atual'] span").first.text
    end
  end
end
