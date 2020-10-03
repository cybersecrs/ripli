require_relative 'lib/ripli.rb'
require_relative 'lib/ripli/version.rb'


Ripli::ProxyScrape.new.shell_exec!
Ripli::HideMyName.new.shell_exec!