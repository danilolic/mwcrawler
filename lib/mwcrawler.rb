require 'mwcrawler/version'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'json'

require 'mwcrawler/classes'
require 'mwcrawler/courses'
require 'mwcrawler/departments'
require 'mwcrawler/helpers'

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
  end
end
