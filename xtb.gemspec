# frozen_string_literal: true

require_relative 'lib/xtb/version'

Gem::Specification.new do |spec|
  spec.name = 'xtb'
  spec.version = Xtb::VERSION
  spec.authors = ['Jacek Maciag']
  spec.email = ['jacek.maciag@gmail.com']

  spec.summary = 'XTB API client for Ruby.'
  spec.description = <<~DESC
    The XTB API (xAPI) client for Ruby provides a simple and easy to use interface to interact with XTB API.
  DESC
  spec.homepage = 'https://github.com/jacekmaciag/xtb'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'connection_pool', '~> 2.4'
  spec.add_dependency 'openssl', '~> 3.1.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
