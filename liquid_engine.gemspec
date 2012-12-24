# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'liquid_engine'
  s.version           = '1.0'
  s.authors           = ["Alexander Negoda"]
  s.email             = ["alexander.negoda@gmail.com"]
  s.description       = 'Liquid Engine extension for Refinery CMS + Spree E-Commerce'
  s.summary           = 'Refinery Liquid Engine extension for Refinery CMS + Spree E-Commerce'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '>= 2.0.8'
  s.add_dependency             'spree', '>= 1.2.0'
end
