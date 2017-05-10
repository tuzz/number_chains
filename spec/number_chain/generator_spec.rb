require "spec_helper"

RSpec.describe NumberChain::Generator do
  it "can generate exponentiated terms" do
    terms = described_class.generate_exponentiated_terms(5)
    expect(terms.strip).to eq "total += numberOfLettersUpto1000(remainder, false);"

    terms = described_class.generate_exponentiated_terms(555)
    expect(terms.strip).to eq "total += numberOfLettersUpto1000(remainder, false);"

    terms = described_class.generate_exponentiated_terms(5_555)
    expect(terms.strip).to eq [
      "milles, remainder = remainder.divmod(1000);",

      "total += numberOfLettersUpto1000(remainder, false);",

      "total += numberOfLettersUpto1000(milles, true);",
      "total += milles.zero? ? 0 : 5;",
    ].join("\n")

    terms = described_class.generate_exponentiated_terms(5_555_555)
    expect(terms.strip).to eq [
      "millions, remainder = remainder.divmod(1000000);",
      "milles, remainder = remainder.divmod(1000);",

      "total += numberOfLettersUpto1000(remainder, false);",

      "total += numberOfLettersUpto1000(milles, true);",
      "total += milles.zero? ? 0 : 5;",

      "total += numberOfLettersUpto1000(millions, false);",
      "total += millions.zero? ? 0 : 7;",
      "total += millions > 1 ? 1 : 0;",
    ].join("\n")

    terms = described_class.generate_exponentiated_terms(555_555_555_555_555_555)
    expect(terms.strip).to eq [
      "billiards, remainder = remainder.divmod(1000000000000000);",
      "billions, remainder = remainder.divmod(1000000000000);",
      "milliards, remainder = remainder.divmod(1000000000);",
      "millions, remainder = remainder.divmod(1000000);",
      "milles, remainder = remainder.divmod(1000);",

      "total += numberOfLettersUpto1000(remainder, false);",

      "total += numberOfLettersUpto1000(milles, true);",
      "total += milles.zero? ? 0 : 5;",

      "total += numberOfLettersUpto1000(millions, false);",
      "total += millions.zero? ? 0 : 7;",
      "total += millions > 1 ? 1 : 0;",

      "total += numberOfLettersUpto1000(milliards, false);",
      "total += milliards.zero? ? 0 : 8;",
      "total += milliards > 1 ? 1 : 0;",

      "total += numberOfLettersUpto1000(billions, false);",
      "total += billions.zero? ? 0 : 7;",
      "total += billions > 1 ? 1 : 0;",

      "total += numberOfLettersUpto1000(billiards, false);",
      "total += billiards.zero? ? 0 : 8;",
      "total += billiards > 1 ? 1 : 0;",
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
    expect(result).to eq [[3, "mille"]]

    result = described_class.calculate_exponentiated_terms(55_555)
    expect(result).to eq [[3, "mille"]]

    result = described_class.calculate_exponentiated_terms(555_555)
    expect(result).to eq [[3, "mille"]]

    result = described_class.calculate_exponentiated_terms(5_555_555)
    expect(result).to eq [[3, "mille"], [6, "million"]]

    result = described_class.calculate_exponentiated_terms(55_555_555)
    expect(result).to eq [[3, "mille"], [6, "million"]]

    result = described_class.calculate_exponentiated_terms(555_555_555)
    expect(result).to eq [[3, "mille"], [6, "million"]]

    result = described_class.calculate_exponentiated_terms(5_555_555_555)
    expect(result).to eq [[3, "mille"], [6, "million"], [9, "milliard"]]
  end
end
