def format_hours(schedules, row)
	while !schedules.empty? do
		schedule = []
		schedule << schedules.slice!(0) # DIA
		schedule << schedules.slice!(0) # HORÁRIO DE INÍCIO
		schedule << schedules.slice!(0) # HORÁRIO DE FIM
		schedules.slice!(0) # RETIRANDO LIXO
		schedule << schedules.slice!(0) # LOCAL DA AULA
		row << schedule
	end
end

def format_teachers(teachers)
	teachers = ['A Designar'] if teachers.empty?
	teachers
end

# MODE: TURMAS OU CURSOS
def set_crawler(id_campus, mode)
	search_mode = mode

  url = SITE + search_mode + id_campus.to_s
  page = Nokogiri::HTML(open(url))
end

def write_json(file_name, object)
	File.open(file_name, 'w+') do |f|
    f.write object.to_json
	end
end