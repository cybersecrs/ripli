require_relative 'ripli/proxyscrape'
require_relative 'ripli/hidemyname'
require_relative 'ripli/proxyscan'

  class Collect
    def list(*proxy)
      proxy.each { |type| @list = ""
      Dir.glob(File.join('**', "#{type}.txt")).each { |file|
      File.readlines(file).each { |line| @list << line; puts line }
      File.write("log/#{type}.list", "#{@list}") } }
    end
  end
