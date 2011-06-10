require "configuratron"

RSpec.configure do |c|
  c.mock_with :rspec
end

RUBY18 = !(RUBY_VERSION =~ /^1\.8/).nil?
