# frozen_string_literal: true

require_relative '../lib/ripli.rb'

Ripli::CustomParser.descendants.each { |custom_parser| custom_parser.new.shell_exec! }
