require 'rails_helper'

RSpec.describe Fibonacci do
  it "computes the right number given the sequence" do
    expect(Fibonacci.(10)).to eq 55
  end

  it "sets a hard-limit on the #{described_class::LIMIT}nd fibonacci number (for performance and accidental abuse)" do
    expect(Fibonacci.(35)).to eq 2178309
  end
end
