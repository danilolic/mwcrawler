# frozen_string_literal: true

require 'mwcrawler/version'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'json'

require 'mwcrawler/classes'
require 'mwcrawler/courses'
require 'mwcrawler/departments'
require 'mwcrawler/subjects'
require 'mwcrawler/helpers'
require 'mwcrawler/crawler'

module Mwcrawler
  # DOMINIO
  SITE = 'https://matriculaweb.unb.br/'
end
