require "spec_helper"

RSpec.describe NumberChain::Generator do
  it "can generate exponentiated terms" do
    terms = described_class.generate_exponentiated_terms(5)
    expect(terms.strip).to eq "total += numberOfLettersUpto1000(remainder);"

    terms = described_class.generate_exponentiated_terms(555)
    expect(terms.strip).to eq "total += numberOfLettersUpto1000(remainder);"

    terms = described_class.generate_exponentiated_terms(5_555)
    expect(terms.strip).to eq [
      "thousands, remainder = remainder.divmod(1000);",

      "total += numberOfLettersUpto1000(remainder);",

      "total += numberOfLettersUpto1000(thousands);",
      "total += thousands.zero? ? 0 : 8;",
    ].join("\n")

    terms = described_class.generate_exponentiated_terms(5_555_555)
    expect(terms.strip).to eq [
      "millions, remainder = remainder.divmod(1000000);",
      "thousands, remainder = remainder.divmod(1000);",

      "total += numberOfLettersUpto1000(remainder);",

      "total += numberOfLettersUpto1000(thousands);",
      "total += thousands.zero? ? 0 : 8;",

      "total += numberOfLettersUpto1000(millions);",
      "total += millions.zero? ? 0 : 7;",
    ].join("\n")

    terms = described_class.generate_exponentiated_terms(555_555_555_555_555_555)
    expect(terms.strip).to eq [
      "quadrillions, remainder = remainder.divmod(1000000000000000);",
      "trillions, remainder = remainder.divmod(1000000000000);",
      "billions, remainder = remainder.divmod(1000000000);",
      "millions, remainder = remainder.divmod(1000000);",
      "thousands, remainder = remainder.divmod(1000);",

      "total += numberOfLettersUpto1000(remainder);",

      "total += numberOfLettersUpto1000(thousands);",
      "total += thousands.zero? ? 0 : 8;",

      "total += numberOfLettersUpto1000(millions);",
      "total += millions.zero? ? 0 : 7;",

      "total += numberOfLettersUpto1000(billions);",
      "total += billions.zero? ? 0 : 7;",

      "total += numberOfLettersUpto1000(trillions);",
      "total += trillions.zero? ? 0 : 8;",

      "total += numberOfLettersUpto1000(quadrillions);",
      "total += quadrillions.zero? ? 0 : 11;",
    ].join("\n")
  end

  it "can calculate exponentiated terms" do
    result = described_class.calculate_exponentiated_terms(5)
    expect(result).to eq []

    result = described_class.calculate_exponentiated_terms(55)
    expect(result).to eq []

    result = described_class.calculate_exponentiated_terms(555)
    expect(result).to eq []

    result = described_class.calculate_exponentiated_terms(5_555)
    expect(result).to eq [[3, "thousand"]]

    result = described_class.calculate_exponentiated_terms(55_555)
    expect(result).to eq [[3, "thousand"]]

    result = described_class.calculate_exponentiated_terms(555_555)
    expect(result).to eq [[3, "thousand"]]

    result = described_class.calculate_exponentiated_terms(5_555_555)
    expect(result).to eq [[3, "thousand"], [6, "million"]]

    result = described_class.calculate_exponentiated_terms(55_555_555)
    expect(result).to eq [[3, "thousand"], [6, "million"]]

    result = described_class.calculate_exponentiated_terms(555_555_555)
    expect(result).to eq [[3, "thousand"], [6, "million"]]

    result = described_class.calculate_exponentiated_terms(5_555_555_555)
    expect(result).to eq [[3, "thousand"], [6, "million"], [9, "billion"]]
  end
end
