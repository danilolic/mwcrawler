module Mwcrawler
	# DOMÍNIO
	SITE = 'https://matriculaweb.unb.br/'.freeze

  class Campuses
    CAMPUSES = {
      darcy_ribeiro: 1,
      planaltina: 2,
      ceilandia: 3,
      gama: 4
    }.freeze

    def self.id(campus)
      raise ArgumentError, "Campus: #{campus} not in: #{CAMPUSES.keys}" unless CAMPUSES.include? campus
      CAMPUSES[campus]
     end

    def self.all
      CAMPUSES
    end
  end

  class Helpers
    def self.format_hours(schedules, row)
      until schedules.empty?
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
    def self.set_crawler(id, search_mode, options = { exact: false })
      id = Campuses.id id unless options[:exact]
      url = SITE + search_mode + id.to_s
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
