require "spec_helper"

RSpec.describe NumberChain::Sentient do
  it "can compile programs" do
    machine_code = described_class.compile("a = 123; expose a;")
    data = JSON.parse(machine_code)

    expect(data["dimacs"]).to eq("p cnf 2 2\n-1 0\n2 0\n")
  end

  it "can run machine code" do
    machine_code = described_class.compile("a = 123; expose a;")
    result = described_class.run(machine_code)

    expect(result).to eq("a" => 123)
  end
end
