module ConversionHelper
  Example = Struct.new(:group, :input_path) do
    def into(expected_path)
      description = %Q(converts "#{input_path}" into "#{expected_path}")
      matcher = ConvertMatcher.new(input_path, expected_path)

      group.specify(description) do
        expect(subject).to matcher
      end
    end
  end

  def converts(input_path)
    Example.new(self, input_path)
  end

  def ignores(input_path)
    description = %Q(does not convert "#{input_path}")
    matcher = ConvertMatcher.new(input_path, input_path)

    specify(description) do
      expect(subject).to matcher
    end
  end
end

class ConvertMatcher
  DEFAULT_CMD = 'bin/alt'

  def initialize(input_path, expected_path = nil)
    @input_path = input_path
    @expected_path = expected_path
  end

  def into(expected_path)
    @expected_path = expected_path
    self
  end

  def matches?(cmd = nil)
    @cmd = cmd || DEFAULT_CMD
    @actual_path = %x{#{@cmd} #{@input_path}}.chomp
    @actual_path == @expected_path
  end

  def description
    %Q(convert "#{@input_path}" into "#{@expected_path}")
  end

  def failure_message
    <<-EOS
expected: "#{@expected_path}"
actual: "#{@actual_path}"
   EOS
  end
end

module ConvertExpectation
  def convert(path)
    ConvertMatcher.new(path)
  end
end

RSpec.configure do |config|
  config.formatter = 'documentation'
  config.extend(ConversionHelper)
  config.include(ConvertExpectation)
  config.order ='random'
end
