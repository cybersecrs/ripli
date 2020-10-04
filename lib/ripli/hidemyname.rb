# frozen_string_literal: true

require 'mechanize'

module Ripli
  class HideMyName
    LOG_DIR = 'log'
    DEFAULT_MAX_TIMEOUT = 1000
    PROXIES_ON_PAGE = 64
    THREADS_COUNT = 3
    PROXY_TYPES_ON_SITE = {
      https: 's',
      socks4: '4',
      socks5: '5'
    }.freeze
    BASE_URL = 'https://hidemy.name/ru/proxy-list/?maxtime=%<max_timeout>d&type=%<type>s&anon=34&start=%<start>d#list'

    def initialize
      @dir = "#{LOG_DIR}/#{self.class.name.split('::').last.downcase}"
      Dir.mkdir(LOG_DIR) unless Dir.exist?(LOG_DIR)
      Dir.mkdir(@dir) unless Dir.exist?(@dir)
    end

    def shell_exec!
      types = ARGV.empty? ? %w[https socks4 socks5] : ARGV
      types.each(&method(:save_proxy_chains))
    end

    def parse(type, opts = {})
      @type ||= type
      url = format(BASE_URL,
                   max_timeout: opts[:max_timeout] || DEFAULT_MAX_TIMEOUT,
                   type: PROXY_TYPES_ON_SITE[type.to_sym],
                   start: opts[:start] || 0)
      doc = Mechanize.new.get(url)
      proxies = extract_proxies(doc)
      proxies += paginate(doc) if opts[:start].to_i.zero?
      proxies
    end

    def save_proxy_chains(type)
      File.open("#{@dir}/#{type}.txt", 'wb') do |file|
        parse(type).uniq.each { |proxy| file << "#{proxy}\n" }
      end
    end

    private

    def paginate(doc)
      last_page = doc.at_xpath('//div[@class="pagination"]//li[not(@class)][last()]/a')&.text.to_i
      threads = (1...last_page).map do |page_number|
        Thread.new { parse(@type, start: page_number * PROXIES_ON_PAGE) }
      end
      threads.flat_map { |t| t.join.value }
    end

    def extract_proxies(doc)
      doc.xpath('//table/tbody/tr').map do |proxy_node|
        ip   = proxy_node.at_xpath('./td[1]')&.text
        port = proxy_node.at_xpath('./td[2]')&.text
        if ip.nil? || port.nil?
          puts 'Empty proxy find in site!'
          next
        end
        "#{@type}\t#{ip}\t\t#{port}"
      end
    end
  end
end

Ripli::HideMyName.new.shell_exec!
