# encoding: utf-8
#================================================================================#
#                      Ruby Proxychains List Downloader                          #
#--------------------------------------------------------------------------------#
#                                                                                #
#   ************************                                                     #
#   *                      *                                                     #
#   *  [Ripli] Downloader  *  by Cybersec-RS                                     #
#   *                      *                                                     #
#   ************************                                                     #
#                                                                                #
#  ============================================================================  #
#      Version: [0.1.0]   -   https://www.github.com/cybersecrs/ripli            #
#  ============================================================================  #
#                                                                                #
#       Author: Linuxander                                                       #
#                                                                                #
#  Description: Project for HACKTOBERFEST-2020                                   #
#               Scrap the internet for free elite proxy servers                  #
#                                                                                #
#               + Save them in Proxychains type (socks5  ip  port)               #   
#               + Each class should scrap one web site                           #
#               + Maximum timeout is 1000ms                                      #
#               + Should add tests for country, data leak, privacy               #
#                                                                                #
#         Note: Please follow Hacktoberfest rules about pull requests!           #
#                                                                                #
#      ====================================================================      #
#                    HAPPY HACKING & MAKE IT OPEN SOURCE !!!                     #
#      ====================================================================      #
#                                                                                #
##################################################################################


require 'mechanize'


module Ripli

 class ProxyScrape

    BASE_URL = "https://api.proxyscrape.com/?request=getproxies&proxytype="

#  Links to download proxy

  def initialize
    @total   =  0
    @home    =  "log"; Dir.mkdir(@home) unless Dir.exist?(@home)
    @https   =  "#{BASE_URL}https&timeout=1000&country=all&ssl=all&anonymity=all"
    @socks4  =  "#{BASE_URL}socks4&timeout=1000&country=all"
    @socks5  =  "#{BASE_URL}socks5&timeout=1000&country=all"
  end

#  Print multiple arguments

  def printargs(*args)
    args.count.times { |x| print args[x] }
  end

#  Print proxy type

  def printer
    print "\n================================================\n";
    print "[#{@proxy}] ".upcase
    print "proxychains list downloaded\n"
    print "================================================\n\n";
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
    @c   = 0
    temp = ""
    temp << Mechanize.new.get(link).body
    File.write("#{@home}/#{@proxy}.tmp.txt", "#{temp}")
    @chain_list = File.open("#{@home}/#{@proxy}.txt", "wb")
    printer

    File.readlines("#{@home}/#{@proxy}.tmp.txt").each { |line| 
      @chain_list << "#{@proxy}\t#{line.to_s.gsub!(":", "\t\t")}"
      @c += 1
      printargs("#{@proxy}\t", "#{line}") }
    File.delete("#{@home}/#{@proxy}.tmp.txt")
    printargs("\n#{@c} ", "#{@proxy} ", "proxies downloaded\n")
    @total += @c
  end  

#  Execute proxy scrap

  def get(*types)
    types.count.times { |x| proxy(types[x]) }
    printargs("\n#{@total} ", "proxies downloaded from ProxyScrape.com\n\n")
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
end                                                         # END OF CLASS
#================================================================================#
