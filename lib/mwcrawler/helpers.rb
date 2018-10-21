module Mwcrawler
  # Controls available campuses
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

  # Options module
  module Options
    module_function

    @log = false

    def init(options = { log: false })
      @log = options[:log].freeze
    end

    def log_enabled?
      @log
    end
  end

  # Helper methods used throughout the lib
  class Helpers
    def self.format_hours(schedules, row = [])
      until schedules.empty?
        schedule = []
        schedule << schedules.shift # DIA
        schedule << schedules.shift # HORARIO DE INICIO
        schedule << schedules.shift # HORARIO DE FIM
        schedules.shift # RETIRANDO LIXO
        schedule << schedules.shift # LOCAL DA AULA
        row << schedule
      end
      row
    end

    def self.format_teachers(teachers)
      teachers.empty? ? ['A Designar'] : teachers
    end

    # MODE: TURMAS, CURSOS OU CURRICULO
    def self.set_crawler(id, search_mode, options = { exact: false })
      id = Campuses.id id unless options[:exact]
      url = SITE + search_mode + id.to_s
      Nokogiri::HTML(URI.parse(url).open)
    end

    def self.write_json(file_name, object)
      File.open(file_name, 'w+') do |f|
        f.write object.to_json
      end
    end

    def self.log(msg)
      puts msg if Options.log_enabled?
    end

    def self.uri_query_params(uri)
      query_string = URI.parse(uri).query
      query_string.split('&').map { |param| param.split('=') }.to_h
    end
  end
end
