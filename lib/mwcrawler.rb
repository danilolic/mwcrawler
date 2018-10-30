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
require 'mwcrawler/course'

module Mwcrawler
  # DOMINIO
  SITE = 'https://matriculaweb.unb.br/'.freeze
end
