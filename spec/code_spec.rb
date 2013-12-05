require 'spec_helper'
require 'codebreaker/code'

describe Codebreaker::Code do
  Code = Codebreaker::Code
  comparison_with = lambda { |code| Code.new("1234").compare_to(code) }

  it "passes constructor argument to value" do
    expect(Code.new("1234").value).to eq "1234"
  end

  context "when nothing guessed" do
    it { expect(comparison_with["5656"]).to eq "" }
  end

  context "when guessed in right order" do
    it { expect(comparison_with["1234"]).to eq "++++" }
    it { expect(comparison_with["5234"]).to eq "+++" }
    it { expect(comparison_with["1536"]).to eq "++" }
    it { expect(comparison_with["5255"]).to eq "+" }
  end

  context "when guessed in wrong order" do
    it { expect(comparison_with["2341"]).to eq "----" }
    it { expect(comparison_with["5342"]).to eq "---" }
    it { expect(comparison_with["5621"]).to eq "--" }
    it { expect(comparison_with["5651"]).to eq "-" }
  end

  context "when guessed in right and wrong order" do
    it { expect(comparison_with["4132"]).to eq "+---" }
    it { expect(comparison_with["4134"]).to eq "++--" }
    it { expect(comparison_with["1231"]).to eq "+++-" }
    it { expect(comparison_with["1356"]).to eq "+-" }
  end
end
