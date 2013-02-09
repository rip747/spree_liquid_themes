# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'spreefinery_themes'
  s.version = '1.0.1'
  s.authors = ["Alexander Negoda, Zee Yang"]
  s.email = ["alexander.negoda@gmail.com, zee.yang@gmail.com"]
  s.description = 'Themes Engine for RefineryCMS + Spree E-Commerce'
  s.summary = 'Themes Support Engine for RefineryCMS + Spree E-Commerce based on Liquid Templating language'
  s.require_paths = %w(lib)
  s.files = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]
  s.required_ruby_version = '>= 1.9.3'

  # Runtime dependencies
  s.add_dependency 'spreefinery_core'
  s.add_dependency 'rubyzip'
  s.add_dependency 'clot_engine'
  s.add_dependency 'liquid', '>= 2.4.1'
end
