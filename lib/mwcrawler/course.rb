module Mwcrawler
  class Course
    attr_reader :course_program, :course_summary, :bibliography

    def initialize(page)
      @course_summary = page.css('#datatable tr td')[6].text 
      @course_program = page.css('#datatable tr td')[7].text 
      @bibliography = page.css('#datatable tr td')[8].text
    end
  end
end