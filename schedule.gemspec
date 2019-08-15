Gem::Specification.new do |s|
  s.name                      = 'schedule'
  s.version                   = '0.0.1'
  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors                   = ['Rimian Perkins']
  s.date                      = '2019-08-14'
  s.description               = 'An event schedule display'
  s.files                     = Dir['lib/**/*.rb']
  s.test_files                = ['spec/']
  s.homepage                  = 'http://rubygems.org/gems'
  s.require_paths             = ['lib']
  s.rubygems_version          = '1.6.2'
  s.summary                   = 'A simple program that filters the events I can book'

  s.add_dependency 'activesupport'
end
