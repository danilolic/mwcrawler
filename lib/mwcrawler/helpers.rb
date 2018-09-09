module Mwcrawler
	CAMPUSES = {
		darcy_ribeiro: 1,
		planaltina: 2,
		ceilandia: 3,
		gama: 4
	}.freeze

	class Helpers
		def self.format_hours(schedules, row)
			while !schedules.empty? do
				schedule = []
				schedule << schedules.shift # DIA
				schedule << schedules.shift # HORÁRIO DE INÍCIO
				schedule << schedules.shift # HORÁRIO DE FIM
				schedules.shift # RETIRANDO LIXO
				schedule << schedules.shift # LOCAL DA AULA
				row << schedule
			end
		end

		def self.format_teachers(teachers)
			teachers = ['A Designar'] if teachers.empty?
			teachers
		end

		# MODE: TURMAS, CURSOS OU CURRÍCULO
		def self.set_crawler(campus, mode)
			search_mode = mode
			campus_id = CAMPUSES[campus]
		  url = SITE + search_mode + campus_id.to_s
		  page = Nokogiri::HTML(open(url))
		end

		def self.write_json(file_name, object)
			File.open(file_name, 'w+') do |f|
		    f.write object.to_json
			end
		end

		def self.log(msg)
			puts msg if false
		end
	end
end
