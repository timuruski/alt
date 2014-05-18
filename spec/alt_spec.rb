require_relative 'spec_helper'

describe "alt" do
  context "with a source path in lib/" do
    it "returns a path to the test file" do
      expect('bin/alt')
        .to convert('lib/example.rb')
        .into('spec/example_spec.rb')
    end

    it "doesn't mess with the extension" do
      expect('bin/alt')
        .to convert('lib/example.py')
        .into('spec/example_spec.py')
    end
  end

  context "with a test path" do
    it "returns a path to the source file in lib" do
      expect('bin/alt')
        .to convert('spec/example_spec.rb')
        .into('lib/example.rb')
    end
  end

  context "with an ambiguous test path" do
    it "returns the same path" do
      expect('bin/alt')
        .to convert('spec/spec_helper.rb')
        .into('spec/spec_helper.rb')
    end
  end
end
