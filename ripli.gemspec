# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'ripli'
  s.version     = '0.3.0'
  s.summary     = 'Ruby Proxychains Scrapper'
  s.description = 'Scrap web for free proxies and save them separated by type'
  s.authors     = ['Linuxander']
  s.files       = ['lib/ripli.rb']
  s.homepage    = 'https://cybersecrs.github.io/projects/ripli'
  s.license     = 'GPL-3.0-only'

  s.metadata['homepage_uri']    = 'https://cybersecrs.github.io/projects/ripli'
  s.metadata['source_code_uri'] = 'https://github.com/cybersecrs/ripli'
  s.metadata['bug_tracker_uri'] = 'https://github.com/cybersecrs/ripli/issues'

  s.bindir        = ['bin']
  s.executables   = ['ripli.rb']
  s.require_paths = ['lib']

  s.files = ['bin/ripli.rb', 'lib/ripli.rb', 'lib/ripli/proxyscrape.rb', 'lib/ripli/proxyscan.rb', 'lib/ripli/hidemyname.rb',
             'lib/ripli/customparser.rb', 'lib/ripli/customparser_template.rb',  'LICENSE', 'README.md', 'ripli.gemspec', 'CODE_OF_CONDUCT.md']

  s.add_runtime_dependency 'optimist'
  s.add_runtime_dependency 'mechanize'
  s.add_runtime_dependency 'pry'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
end
