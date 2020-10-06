# frozen_string_literal: true

# Template for site scraping class

require_relative 'customparser'

module Ripli
  # class should be inherited from CustomParser
  # class name should be related with sitename
  class CustomParserTemplate < CustomParser
    # from superclass you inherit constants:
    # LOG_DIR = 'log' -> directory to save files with proxies
    # DEFAULT_MAX_TIMEOUT = 1000 -> max timeout of proxy response in ms
    CONSTANT = 'Your constants' # declare your constants here

    # define it if you need initialize some instance variables
    # or perform some preparations (creating directories, etc)
    def initialize
      super # required for creating logger and directory
      # define @mechanize = Mechanize.new { |agent| agent.open_timeout...} if you need add some options to mechanize agent
      # your code here
    end

    # required method!
    # logic of scraping site must be here
    # type -- proxy type: [:https, :socks4, :socks5]
    # opts -- additional params if you need
    # return -- array of stings in format: "<type>\t<ip>\t\t<port>"
    def parse(type, opts = {})
      []
      # for downloading use @mechanize.get(url)
      @logger.info 'Use @logger for print logs in STDOUT'
    rescue Net::OpenTimeout, Net::ReadTimeout
      # rescue exception during downloading page, DEFAULT_MECHANIZE_TIMEOUT=10s
    end

    # If you need additional logic of creating files
    # you can redefine method save_proxy_chains(type)
    #
    # def save_proxy_chains(type)
    #   File.open("#{@dir}/#{type}.txt", 'wb') do |file|
    #     proxies = parse(type.to_sym).uniq
    #     @logger.info "Find #{proxies.size} proxies type #{type} by #{self.class.name}, saved into: #{file.path}"
    #     proxies.each { |proxy| file << "#{proxy}\n" }
    #   end
    # end

    # any additional methods for scraping bellow
    private

    def do_smth
      'Do something helpful'
    end
  end
end
