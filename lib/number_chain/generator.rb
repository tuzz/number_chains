module NumberChain
  module Generator

    class << self
      def bits
        @bits ||= 10
      end

      def bits=(bits)
        @bits = bits
      end

      def max_value
        2 ** (bits - 1) - 1
      end

      def generate(length:)
        <<-SNT
          #{lookup_table}

          # The number of bits needs to be: 2^(b - 1) > maximum
          int#{bits} n, lessthan;

          chain = [];
          chain = chain.push(n);

          #{length - 1}.times(function^ (i) {
            n = numberOfLettersIn(n);
            chain = chain.push(n);
          });

          invariant chain.uniq?;
          invariant chain.last == 4;
          invariant lessthan == -1 ? true : chain.first < lessthan;

          expose chain, lessthan;
        SNT
      end

      def generate_lookup
        <<-SNT
          #{lookup_table}

          int#{bits} n;
          count = numberOfLettersIn(n);

          expose n, count;
        SNT
      end

      def lookup_table
        <<-SNT
          # The number of letters in one..nine
          # 0 is prepended for convenience
          one_lookup = [0, 3, 3, 5, 4, 4, 3, 5, 5, 4];

          # The number of letters in ten..ninety
          ten_lookup = [0, 3, 6, 6, 5, 5, 5, 7, 6, 6];

          # The delta of (eleven..nineteen) - ten - (one..nine)
          teen_lookup = [0, 0, 0, 0, 1, 0, 1, 1, 0, 1];

          function^ numberOfLettersUpto1000 (n) {
            sum = 0;

            hundreds, modulo_100 = n.divmod(100);
            tens, remainder = modulo_100.divmod(10);

            # Add the characters from the ones
            sum += one_lookup[remainder];

            # Add the characters from the tens
            sum += ten_lookup[tens];

            # Add the teen delta if 11 <= modulo_100 <= 19
            sum += modulo_100.between?(11, 19) ? teen_lookup[remainder] : 0;

            # Add the characters from the hundreds
            sum += one_lookup[hundreds];
            sum += hundreds.zero? ? 0 : 7;

            # Add the word 'and'
            and_required = hundreds != 0 && modulo_100 != 0;
            sum += and_required ? 3 : 0;

            return sum;
          };

          function^ numberOfLettersIn (n) {
            total = 0;

            remainder = n;
            #{generate_exponentiated_terms(max_value)}

            return total;
          };
        SNT
      end

      def generate_exponentiated_terms(max)
        terms = ""

        exponentials = calculate_exponentiated_terms(max)

        exponentials.reverse.each do |(digits, word)|
          terms += "\n#{word}s, remainder = remainder.divmod(1#{"0" * digits});"
        end

        terms += "\ntotal += numberOfLettersUpto1000(remainder);"

        exponentials.each do |(digits, word)|
          terms += "\ntotal += numberOfLettersUpto1000(#{word}s);"
          terms += "\ntotal += #{word}s.zero? ? 0 : #{word.length};"
        end

        terms
      end

      def calculate_exponentiated_terms(max)
        digits = max.to_s.length
        exponentials = (digits - 1) / 3

        1.upto(exponentials).map do |exp|
          word = (1000 ** exp).to_words
          word = word[4..-1].gsub(/[^a-z]/, "")

          [exp * 3, word]
        end
      end
    end
  end
end
