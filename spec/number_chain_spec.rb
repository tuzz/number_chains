require "spec_helper"

RSpec.describe NumberChain do
  def validate_chain(chain)
    counts = chain.map do |n|
      n.to_words(hundreds_with_union: true).gsub(/[^a-z]/, "").length
    end

    chain[1..-1].zip(counts).each do |actual, expected|
      expect(actual).to eq(expected)
    end
  end

  it "can find number chains" do
    chain = NumberChain.search(length: 3)
    validate_chain(chain)

    chain = NumberChain.search(length: 6)
    validate_chain(chain)
  end

  it "can find a number chain that starts less than a given number" do
    chain = NumberChain.search(length: 6, lessthan: 24)
    expect(chain).to eq [23, 11, 6, 3, 5, 4]
  end

  it "returns nil if no number chain exists that is less than the number" do
    chain = NumberChain.search(length: 6, lessthan: 23)
    expect(chain).to be_nil
  end

  it "can find the smallest number chain less than a given number" do
    chain = NumberChain.smallest(length: 6, lessthan: 100)
    expect(chain).to eq [23, 11, 6, 3, 5, 4]
  end

  it "can yield each chain as it minimises" do
    chains = []

    NumberChain.smallest(length: 6, lessthan: 100) do |chain|
      chains.push(chain)
    end

    expect(chains).not_to be_empty
  end
end
