require 'rails_helper'

RSpec.describe Fibonacci do
  it "computes the right number given the sequence" do
    expect(Fibonacci.(10)).to eq 55
  end

  it "sets a hard-limit on the #{described_class::LIMIT}nd fibonacci number (for performance and accidental abuse)" do
    expect(Fibonacci.(35)).to eq 2178309
  end

  it "caches subsequent fibonacci calls" do
    start = Time.now
    50.times { Fibonacci.(32) }
    execution_time = Time.now - start
    expect(execution_time < 1.second).to be true
  end
end
