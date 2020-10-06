# frozen_string_literal: true

require_relative '../lib/ripli.rb'
require 'pry'

<<<<<<< HEAD
Ripli::ProxyScrape.new.shell_exec!
Ripli::HideMyName.new.shell_exec!
Ripli::ProxyScan.new.shell_exec!
=======
AVAILABLE_TYPES = %w[https socks4 socks5].freeze

opts = Optimist.options do
  opt :type, 'Types of proxies to scrape', type: :strings, default: AVAILABLE_TYPES
end

if (opts.type.uniq - AVAILABLE_TYPES).any?
  raise "Incorrect proxy type: #{opts.type.uniq - AVAILABLE_TYPES}, available types: #{AVAILABLE_TYPES}"
end

Ripli::CustomParser.descendants.each { |custom_parser| custom_parser.new.shell_exec!(opts.type) }
>>>>>>> 44098c595dea793bb8e23ee4db3184e13737bb6e
