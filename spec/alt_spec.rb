require_relative 'spec_helper'

describe "bin/alt" do
  subject { 'bin/alt' }

  context "relative source paths" do
    it { should take('lib/example.rb')
           .and_resolve('spec/example_spec.rb') }

    it { should take('lib/example.rb')
           .and_resolve('spec/example_spec.rb') }

    it { should take('lib/example.py')
           .and_resolve('spec/example_spec.py') }

    it { should take('app/models/user.rb')
           .and_resolve('spec/models/user_spec.rb') }
  end

  context "relative test paths" do
    it { should take('spec/spec_helper.rb')
           .and_resolve('spec/spec_helper.rb') }

    it { should take('spec/example_spec.rb')
           .and_resolve('lib/example.rb') }

    it { should take('spec/example_spec.py')
           .and_resolve('lib/example.py') }

    it { should take('spec/models/user_spec.rb')
           .and_resolve('app/models/user.rb') }
  end

  context "absolute source paths" do
    it { should take('/workspace/example/lib/example.rb')
           .and_resolve('/workspace/example/spec/example_spec.rb') }
  end

  context "absolute test paths" do
    it { should take('/workspace/example/spec/example_spec.rb')
           .and_resolve('/workspace/example/lib/example.rb') }
  end
end
