require "numbers_and_words"
require "json"

require "number_chain/generator"
require "number_chain/sentient"

module NumberChain
  class << self
    def lookup(n)
      machine_code = cache("lookup_program") do
        program = Generator.generate_lookup
        Sentient.compile(program)
      end

      result = Sentient.run(machine_code, n: n)
      result["count"] if result["count"]
    end

    def search(length:, lessthan: -1)
      machine_code = cache("search_program_#{length}_#{Generator.bits}") do
        program = Generator.generate(length: length)
        Sentient.compile(program)
      end

      result = Sentient.run(machine_code, lessthan: lessthan)
      result["chain"] if result["chain"]
    end

    def smallest(length:, lessthan: -1)
      previous = nil
      current = search(length: length, lessthan: lessthan)

      return if current.nil?

      until current.nil?
        previous = current
        yield(previous) if block_given?

        lessthan = previous.first
        current = search(length: length, lessthan: lessthan)
      end

      previous
    end

    private

    def cache(key, &block)
      @cache ||= {}
      @cache[key] ||= block.call
    end
  end
end
