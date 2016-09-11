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

task :plot do
  NumberChain::Plotter.plot(
    [
      [23373, 3373, 3773],
      [17, 14, 103],
      [3, 17, 23],
      [17, 13, 3],
      [4, 13, 13],
      [4, 1, 23],
      [19, 6, 1],
      [10, 10, 2],
      [7, 2, 8],
      [9, 6, 6],
      [3, 13, 2],
      [6, 10, 8],
      [9, 5, 5],
      [3, 13, 4],
      [16, 8, 1],
      [17, 3, 3],
      [3, 23, 1]
  ], "plot.gif")
  `open plot.html`
end

task default: :run
