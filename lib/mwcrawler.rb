require 'mwcrawler/version'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'json'

require 'mwcrawler/classes'
require 'mwcrawler/courses'
require 'mwcrawler/departments'
require 'mwcrawler/helpers'
require 'mwcrawler/crawler'

module Mwcrawler
  class Crawler
    include Mwcrawler

    def courses(campus = :darcy_ribeiro)
      Courses.scrap campus
    end

    def classes(campus = :darcy_ribeiro)
      Classes.scrap campus
    end

    def departments(campus = :darcy_ribeiro)
      Departments.scrap campus
    end
  end
end
