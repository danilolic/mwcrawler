# frozen_string_literal: true

module Mwcrawler
  # Main api for crawling
  class Crawler
    include Mwcrawler

    SCRAPPERS = {
      courses: Courses,
      classes: Classes,
      departments: Departments
    }.freeze

    SCRAPPERS.keys.each do |method|
      define_method(method) do |campus = :darcy_ribeiro, options = { log: false }|
        Options.init(options)
        SCRAPPERS[method].scrap campus
      end
    end

    def subjects(department, options = { log: false })
      Options.init(options)
      Subjects.scrap department, options
    end

    def semester
      page = Helpers.set_crawler(nil, 'graduacao/default.aspx', exact: true)
      page.css("a[title='Período Atual'] span").first.text
    end

    def find_course(course_id)
      page = Helpers.set_crawler(nil, "graduacao/disciplina.aspx?cod=#{course_id}", exact: true)
      Mwcrawler::Course.new(page)
    end
  end
end
