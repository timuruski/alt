require_relative 'spec_helper'

describe "bin/alt" do
  subject { 'bin/alt' }

  context "relative source paths" do
    converts('lib/example.rb')
      .into('spec/example_spec.rb')

    converts('lib/example.py')
      .into('spec/example_spec.py')

    converts('app/models/user.rb')
      .into('spec/models/user_spec.rb')
  end

  context "relative test paths" do
    ignores('spec/spec_helper.rb')

    converts('spec/example_spec.rb')
      .into('lib/example.rb')

    converts('spec/example_spec.py')
      .into('lib/example.py')

    # converts('spec/models/user_spec.rb')
    #   .into('app/models/user.rb')
  end

  context "absolute source paths" do
    converts('/workspace/example/lib/example.rb')
      .into('/workspace/example/spec/example_spec.rb')
  end

  context "absolute test paths" do
    converts('/workspace/example/spec/example_spec.rb')
      .into('/workspace/example/lib/example.rb')
  end
end
