describe "alt" do
  context "with a source path in lib/" do
    it "returns a path to the test file" do
      test_path = `bin/alt lib/example.rb`.chomp
      expect(test_path).to eql('spec/example_spec.rb')
    end
  end

  context "with a test path" do
    it "returns a path to the source file in lib" do
      source_path = `bin/alt spec/example_spec.rb`.chomp
      expect(source_path).to eql('lib/example.rb')
    end
  end
end
