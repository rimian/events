Gem::Specification.new do |s|
  s.name               = "schedule"
  s.version            = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rimian Perkins"]
  s.date = %q{2019-08-14}
  s.description = %q{An event schedule display}
  s.files = Dir['lib/**/*.rb']
  s.test_files = ["spec/"]
  s.homepage = %q{http://rubygems.org/gems}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A simple program that filters the events I can book}
end
