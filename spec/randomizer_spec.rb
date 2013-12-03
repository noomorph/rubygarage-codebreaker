require 'spec_helper'
require 'codebreaker/randomizer'

describe Codebreaker::Randomizer do
  it "generates 4-char string of 1-6 digits" do
    expect(subject.generate).to match(/[1-6]{4}/)
  end
end
