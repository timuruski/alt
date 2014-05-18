module ConvertExpectation
  def convert(path)
    ConvertMatcher.new(path)
  end

  class ConvertMatcher
    def initialize(path)
      @input_path = path
    end

    def into(expected_path)
      @expected_path = expected_path
      self
    end

    def matches?(cmd)
      @cmd = cmd
      @actual_path = %x{#{@cmd} #{@input_path}}.chomp
      @actual_path == @expected_path
    end

    def failure_message
      %Q(expected "#{@expected_path}", got "#{@actual_path}")
    end
  end
end

RSpec.configure do |config|
  config.include(ConvertExpectation)
end
