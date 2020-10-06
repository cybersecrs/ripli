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
<<<<<<< HEAD

#  Get Proxies

  def get_proxy(link)
    temp = ""
    temp << Mechanize.new.get(link).body
    File.write("#{@dir}/#{@proxy}.tmp.txt", "#{temp}")
    @chain_list = File.open("#{@dir}/#{@proxy}.txt", "wb")

    File.readlines("#{@dir}/#{@proxy}.tmp.txt").each { |line| 
      @chain_list << "#{@proxy}\t#{line.to_s.gsub!(":", "\t\t")}"
        print "#{@proxy}\t#{line}" }
    File.delete("#{@dir}/#{@proxy}.tmp.txt")
  end  

#  Execute proxy scrap

  def get(*types)
    types.count.times { |x| proxy(types[x]) }
  end

#  Execute from shell, args as proxy-types

  def shell_exec!
    if ARGV.empty?
      get("https", "socks4", "socks5")
    else
      ARGV.count.times { |x| get(ARGV[x]) }
    end
  end

 end
end                                                         
=======
end
>>>>>>> 44098c595dea793bb8e23ee4db3184e13737bb6e
