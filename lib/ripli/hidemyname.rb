# frozen_string_literal: true

require_relative 'customparser'

module Ripli
  class HideMyName < CustomParser
    PROXIES_ON_PAGE = 64
    THREADS_COUNT = 3
    PROXY_TYPES_ON_SITE = {
      https: 's',
      socks4: '4',
      socks5: '5'
    }.freeze
    BASE_URL = 'https://hidemy.name/ru/proxy-list/?maxtime=%<max_timeout>d&type=%<type>s&anon=34&start=%<start>d#list'

    def parse(type, opts = {})
      @type ||= type
      url = format(BASE_URL,
                   max_timeout: opts[:max_timeout] || DEFAULT_MAX_TIMEOUT,
                   type: PROXY_TYPES_ON_SITE[type.to_sym],
                   start: opts[:start] || 0)
      doc = @mechanize.get(url)
      proxies = extract_proxies(doc)
      proxies += paginate(doc) if opts[:start].to_i.zero?
      proxies
    rescue Net::OpenTimeout, Net::ReadTimeout
      @log.error '[HideMyName] Sorry, site is unavailable!'
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
        next if ip.nil? || port.nil?

        "#{@type}\t#{ip}\t\t#{port}"
      end
    end
  end
end