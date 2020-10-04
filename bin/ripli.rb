# frozen_string_literal: true

require_relative '../lib/ripli.rb'
require 'pry'

Ripli::ProxyScrape.new.shell_exec!
Ripli::HideMyName.new.shell_exec!
