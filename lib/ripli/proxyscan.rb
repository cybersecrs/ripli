# frozen_string_literal: true

require_relative 'customparser'

module Ripli
  class ProxyScan < CustomParser
    BASE_URL = 'https://www.proxyscan.io/download?type='

    URL_PARAMS = {
      https: 'https&timeout=%d&country=all&ssl=all&anonymity=all',
      socks4: 'socks4&timeout=%d&country=all',
      socks5: 'socks5&timeout=%d&country=all'
    }.freeze

    def parse(type, opts = {})
      max_timeout = opts[:max_timeout] || DEFAULT_MAX_TIMEOUT
      link = [BASE_URL, URL_PARAMS[type] % max_timeout].join
      response = @mechanize.get(link).body

      response.split.map { |proxy| "#{type}\t#{proxy.sub(':', "\t\t")}" }
    rescue Net::OpenTimeout, Net::ReadTimeout
      @log.error '[ProxyScrape] Sorry, site is unavailable!'
    end
  end
end
