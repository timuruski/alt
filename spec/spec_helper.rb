class ResolveMatcher
  DEFAULT_CMD = 'bin/alt'

  def initialize(input_path, expected_path = nil)
    @input_path = input_path
    @expected_path = expected_path
  end

  def and_resolve(expected_path)
    @expected_path = expected_path
    self
  end

  def matches?(cmd = nil)
    @cmd = cmd || DEFAULT_CMD
    @actual_path = %x{#{@cmd} #{@input_path}}.chomp
    @actual_path == @expected_path
  end

  def description
    %Q(resolve "#{@input_path}" into "#{@expected_path}")
  end

  def failure_message
    <<-EOS
expected: "#{@expected_path}"
actual: "#{@actual_path}"
   EOS
  end
end

module ResolveExpectation
  def take(path)
    ResolveMatcher.new(path)
  end
end

RSpec.configure do |config|
  config.formatter = 'documentation'
  config.include(ResolveExpectation)
  config.order ='random'
end
