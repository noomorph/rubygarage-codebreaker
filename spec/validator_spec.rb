require 'spec_helper'
require 'codebreaker/validator'

describe Codebreaker::Validator do

  ERR_TOO_LONG       = Codebreaker::Validator::ERR_TOO_LONG
  ERR_TOO_SHORT      = Codebreaker::Validator::ERR_TOO_SHORT
  ERR_ONLY_DIGITS    = Codebreaker::Validator::ERR_ONLY_DIGITS
  ERR_INVALID_DIGITS = Codebreaker::Validator::ERR_INVALID_DIGITS
  ERR_MUST_BE_STRING = Codebreaker::Validator::ERR_MUST_BE_STRING

  it "raises error when guess contains any digit = 7|8|9|0" do
    codes = ["7123", "1823", "1293", "1230"]
    codes.each do |code|
      expect { subject.validate! code }.to raise_error ArgumentError, ERR_INVALID_DIGITS
    end
  end

  it "raises error when code is too long" do
    expect { subject.validate! "12345" }.to raise_error ArgumentError, ERR_TOO_LONG
  end

  it "raises error when code is too short" do
    expect { subject.validate! "123" }.to raise_error ArgumentError, ERR_TOO_SHORT
  end

  it "raises error when string contains not only digits" do
    expect { subject.validate! "A123" }.to raise_error ArgumentError, ERR_ONLY_DIGITS
  end

  it "raises error when code is not a string" do
    expect { subject.validate! 1234 }.to raise_error TypeError, "#{ERR_MUST_BE_STRING} Fixnum."
  end

  it "does not raise error when code is [1-6][1-6][1-6][1-6]" do
    codes = ["1234", "2345", "3456", "6161"]
    codes.each do |code|
      expect { subject.validate! code }.not_to raise_error
    end
  end
end
