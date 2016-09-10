require "rspec"
require "number_chain"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.color = true

  config.before(:suite) do
    NumberChain::Generator.bits = 42 # upto 2,199,023,255,551
  end
end
