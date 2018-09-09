module Mwcrawler
	module Classes
		def self.scrap(id_campus)
			# CADA TURMA SERÁ UMA LINHA, ENTÃO rows É O CONJUNTO DE TODAS AS TURMAS
			rows = []

			# LISTA DE DEPARTAMENTOS (inicialmente vazia)
			dep_links = []

			# LISTA DE MATÉRIAS (inicialmente vazia)
			course_links = []

			page = Helpers.set_crawler(id_campus, 'graduacao/oferta_dep.aspx?cod=')

		  dep_links = page.css('#datatable tbody tr td:nth-child(3) a')
		                  .map { |link| link['href'] }


		  # ITERA SOBRE TODOS OS DEPARTAMENTOS PEGANDO TODAS AS MATÉRIAS
			dep_links.each do |dep_link|
			  url = SITE + dep_link
			  page = Nokogiri::HTML(open(url))
		    course_links << page.css('#datatable tr td:nth-child(2) a')
		                        .map { |link| link['href'] }
			end
			course_links.flatten!
		  # CONTADORES
			classes = 0
			class_count = 0
		  # ITERA SOBRE TODAS AS MATÉRIAS PEGANDO TODAS AS TURMAS
			course_links.each do |course_link|
			  url = SITE + course_link
			  page = Nokogiri::HTML(open(url))
			  page_classes = page.css('.tabela-oferta .turma').map { |item| item.text}
			  department 	 = page.css('#datatable tr:first-child a').text
			  code 				 = page.css('#datatable')[0].css('tr:nth-child(2) td').text
			  course  		 = page.css('#datatable')[0].css('tr:nth-child(3) td').text
				credits 		 = page.css('#datatable')[0].css('tr:nth-child(4) td').text

			  page_classes.each_with_index do |cl, i|
			    row = {}
			    row[:department] = department
			    row[:code] = code
			    row[:course] = course
			    row[:credits] = credits
					row[:name] = cl
					row[:vacancies_total] = page.css('.tabela-oferta')[i]
																			.css('.tabela-vagas tr:nth-child(1) td:nth-child(3)').text
					row[:vacancies_occupied] = page.css('.tabela-oferta')[i]
																				 .css('.tabela-vagas tr:nth-child(2) td:nth-child(3)').text

					row[:vacancies_free] = page.css('.tabela-oferta')[i]
																		 .css('.tabela-vagas tr:nth-child(3) td:nth-child(3)').text

			    # HORÁRIOS
					schedules = page.css('.tabela-oferta')[i]
													.css('tr td:nth-child(4) .table')
													.css('td').map { |item| item.text }

					row[:schedules] = []
					format_hours(schedules, row[:schedules])

					# PROFESSORES
					teachers = page.css('.tabela-oferta')[i]
												 .css('tr td:nth-child(5) td')
												 .map { |item| item.text }

			    row[:teachers] = []
					row[:teachers] = format_teachers(teachers)
			    rows << row
			    class_count = class_count + 1
			    classes = class_count
			    puts "Total de turmas: #{classes}"
			  end
			end

			rows
		end
	end
end
