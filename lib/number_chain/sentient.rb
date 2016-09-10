require "tempfile"

module NumberChain
  module Sentient
    def self.compile(program)
      file = Tempfile.new
      file.write(program)
      file.close

      `sentient -c -o #{file.path}`
    ensure
      file.unlink
    end

    def self.run(machine_code, assignments = {})
      File.open("/tmp/number_chain.json", "w") { |f| f.puts machine_code }

      assignments = JSON.generate(assignments)

      JSON.parse(
        `sentient -m lingeling -r /tmp/number_chain.json -a '#{assignments}'`
      )
    end
  end
end
