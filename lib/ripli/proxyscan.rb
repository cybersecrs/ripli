# Ripli - Ruby Proxychains List Scrapper
# Project created for Hacktoberfest-2020
# @cybersecrs

require 'mechanize'


module Ripli

 class ProxyScan

    LOG_DIR  = "log"
    BASE_URL = "https://www.proxyscan.io/download?type="

#  Links to download proxy

  def initialize
    @total   =  0
    @https   =  "#{BASE_URL}https"
    @socks4  =  "#{BASE_URL}socks4"
    @socks5  =  "#{BASE_URL}socks5"
    @dir     =  "#{LOG_DIR}/#{self.class.name.split('::').last.downcase}"
    Dir.mkdir(LOG_DIR) unless Dir.exist?(LOG_DIR)
    Dir.mkdir(@dir) unless Dir.exist?(@dir)
  end

#  Proxy type 

  def proxy(type)
    @proxy = type
    case @proxy 
      when "https"  then get_proxy(@https)
      when "socks4" then get_proxy(@socks4)
      when "socks5" then get_proxy(@socks5)   
    end
  end

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
