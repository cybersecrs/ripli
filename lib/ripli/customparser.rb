# frozen_string_literal: true

module Ripli
  require 'mechanize'
  require 'logger'

  class CustomParser
    LOG_DIR = 'log'
    DEFAULT_MAX_TIMEOUT = 1000
    DEFAULT_MECHANIZE_TIMEOUT = 10

    def initialize
      @dir = "#{LOG_DIR}/#{self.class.name.split('::').last.downcase}"
      @mechanize = Mechanize.new do |agent|
        agent.open_timeout = DEFAULT_MECHANIZE_TIMEOUT
        agent.read_timeout = DEFAULT_MECHANIZE_TIMEOUT
      end
      Dir.mkdir(LOG_DIR) unless Dir.exist?(LOG_DIR)
      Dir.mkdir(@dir) unless Dir.exist?(@dir)
      @logger = Logger.new(STDOUT)
    end

    def shell_exec!(types)
      types.each(&method(:save_proxy_chains))
    end

    protected

    def parse(_type, _opts = {})
      raise "Class #{self.class.name} should implement method #parse(type, opts = {})"
    end

    def save_proxy_chains(type)
      File.open("#{@dir}/#{type}.txt", 'wb') do |file|
        proxies = parse(type.to_sym).uniq
        @logger.info "Find #{proxies.size} proxies type #{type} by #{self.class.name}, saved into: #{file.path}"
        proxies.each { |proxy| file << "#{proxy}\n" }
      end
    end
  end
end

class Class
  def descendants
    ObjectSpace.each_object(::Class).select {|klass| klass < self }
  end
end
