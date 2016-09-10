$LOAD_PATH.unshift("lib")
require "number_chain"

task :run do
  length = 2
  puts "Searching for the smallest chain of length 2..."

  loop do
    smallest = NumberChain.smallest(length: length) do |chain|
      puts "  #{chain.inspect}"
    end

    if smallest
      length += 1
      puts "\nSearching for the smallest chain of length #{length}..."
    else
      puts "  none (between 1 and #{NumberChain::Generator.max_value}, increasing...)"
      NumberChain::Generator.bits += 4
    end
  end
end

task default: :run
