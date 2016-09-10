require "spec_helper"

RSpec.describe NumberChain do
  def validate_length(n)
    expected = n.to_words(hundreds_with_union: true).gsub(/[^a-z]/, "").length
    actual = NumberChain.lookup(n)

    expect(expected).to eq(actual),
      "got #{actual} for #{n} but it should be #{expected}"
    print "#{n} "
  end

  it "returns the correct counts for 1..99" do
    (1..23).each { |n| validate_length(n) }

    validate_length(30)
    validate_length(31)

    validate_length(42)
    validate_length(43)

    validate_length(54)
    validate_length(55)

    validate_length(66)
    validate_length(67)

    validate_length(78)
    validate_length(79)

    validate_length(80)
    validate_length(81)

    validate_length(90)
    validate_length(99)
  end

  it "returns the correct counts for 100..999" do
    (100..115).each { |n| validate_length(n) }

    validate_length(120)
    validate_length(127)
    validate_length(128)

    validate_length(200)
    validate_length(205)
    validate_length(215)

    validate_length(300)
    validate_length(309)
    validate_length(385)

    validate_length(465)
    validate_length(489)

    validate_length(548)
    validate_length(599)

    validate_length(643)
    validate_length(789)
    validate_length(818)

    validate_length(917)
    validate_length(999)
  end

  it "returns the correct counts for 1000..999_999" do
    validate_length(1_000)
    validate_length(1_001)
    validate_length(1_111)
    validate_length(1_717)
    validate_length(3_456)
    validate_length(9_999)

    validate_length(12_345)
    validate_length(23_456)
    validate_length(51_717)
    validate_length(89_891)

    validate_length(114_114)
    validate_length(345_678)
    validate_length(456_789)
    validate_length(999_999)
  end

  it "returns the correct counts for 1_000_000..999_999_999" do
    validate_length(1_000_000)
    validate_length(1_111_111)
    validate_length(2_345_678)
    validate_length(9_123_987)

    validate_length(14_148_826)
    validate_length(29_171_632)
    validate_length(99_999_999)

    validate_length(123_456_789)
    validate_length(876_161_771)
    validate_length(999_999_999)
  end

  it "returns the correct counts for 1_000_000_000..999_999_999_999" do
    validate_length(1_000_000_000)
    validate_length(1_234_567_890)
    validate_length(9_876_543_210)
    validate_length(172_839_405_123)
    validate_length(999_999_999_999)
  end
end
