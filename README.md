## Number Chains

This project is a response to
[this video](https://www.youtube.com/watch?v=LYKn0yUTIU4)
from standupmaths. It finds chains of numbers that are connected by the number
of letters within the words that represent them. For example:

```
[11, 6, 3, 5, 4]

11 is written as "eleven" which has 6 letters
6 is written as "six" which has 3 letters
3 is written as "three" which has 5 letters
5 is written as "five" which has 4 letters
4 is written as "four" which has 4 letters
```

The above chain has a length of 5. The challenge is to find a chain of numbers
for a given length that has the smallest possible start value. The chain above
starts at 11 and it is the smallest number that produces a chain that is 5
numbers long.

This project is an attempt at finding these chains of numbers.

## How does it work

This project uses [Sentient](http://sentient-lang.org/) which is an experimental
programming language I've been working on for the last year or so. It is very
good at solving discrete, well-defined problems like this.

It uses Ruby to generate a Sentient program which is then executed repeatedly to
minimise the first number in the chain. It runs surprisingly quickly and checks
the range 2^69 - 1 in a matter of seconds. Beyond this, Sentient hits an
inherent limitation of the platform it runs on (node), which I plan to address
at some point. It'd be able to check much much larger numbers if so.

## Results

There are two conventions described in the video. The first is to include the
word 'and' between numbers that exceed 100, e.g. one hundred **and** three. The
second convention is to omit this. Here are the minimum numbers for chains of
each length:

```
1: [4]
2: [5, 4]
3: [3, 5, 4]
4: [1, 3, 5, 4]
5: [11, 6, 3, 5, 4]
6: [23, 11, 6, 3, 5, 4]
7: [124, 23, 11, 6, 3, 5, 4] (with 'and')
7: [323, 23, 11, 6, 3, 5, 4] (without 'and')
8: [113373373373, 124, 23, 11, 6, 3, 5, 4] (with 'and')
```

Written in full, that last number is:

>one hundred and thirteen billion three hundred and seventy three million three
>hundred and seventy three thousand three hundred and seventy three

Longer chains are unknown. Interestingly, there is a chain of 8 with 'and' but
not without. The program checks the range 1 up to 590,295,810,358,705,651,711 so
they must lie beyond that.

I also had a go at finding chains that begin with a minus number. Here are the
chains with the start number closest to zero for each length:

```
1: no solutions
2: no solutions
3: [-5, 9, 4]
4: [-1, 8, 5, 4]
5: [-7, 10, 3, 5, 4]
6: [-12, 11, 6, 3, 5, 4]
7: [-103, 23, 11, 6, 3, 5, 4] (with 'and')
7: [-113, 23, 11, 6, 3, 5, 4] (without 'and')
8: [-101373373373, 124, 23, 11, 6, 3, 5, 4] (with 'and')
```

## How do I run it

You need to install Ruby and run `bundle install`.

You need to install [Sentient](http://sentient-lang.org/tutorial/installation)
as well as [Riss](https://github.com/sentient-lang/homebrew-riss) and
[Lingeling](https://github.com/sentient-lang/homebrew-lingeling).

You can then run `bundle exec rake` to view the following output:

```
$ time bundle exec rake
Searching for the smallest chain of length 2...
  [5, 4]

Searching for the smallest chain of length 3...
  [7, 5, 4]
  [3, 5, 4]

Searching for the smallest chain of length 4...
  [14, 8, 5, 4]
  [13, 8, 5, 4]
  [10, 3, 5, 4]
  [2, 3, 5, 4]
  [1, 3, 5, 4]

Searching for the smallest chain of length 5...
  [76, 10, 3, 5, 4]
  [12, 6, 3, 5, 4]
  [11, 6, 3, 5, 4]

Searching for the smallest chain of length 6...
  [358, 25, 10, 3, 5, 4]
  [355, 24, 10, 3, 5, 4]
  [307, 20, 6, 3, 5, 4]
  [303, 20, 6, 3, 5, 4]
  [116, 20, 6, 3, 5, 4]
  [77, 12, 6, 3, 5, 4]
  [27, 11, 6, 3, 5, 4]
  [23, 11, 6, 3, 5, 4]

Searching for the smallest chain of length 7...
  [314, 23, 11, 6, 3, 5, 4]
  [313, 23, 11, 6, 3, 5, 4]
  [153, 23, 11, 6, 3, 5, 4]
  [148, 23, 11, 6, 3, 5, 4]
  [143, 23, 11, 6, 3, 5, 4]
  [124, 23, 11, 6, 3, 5, 4]

Searching for the smallest chain of length 8...
  none (between 1 and 511, increasing...)
  none (between 1 and 8191, increasing...)
  none (between 1 and 131071, increasing...)
  none (between 1 and 2097151, increasing...)
  none (between 1 and 33554431, increasing...)
  none (between 1 and 536870911, increasing...)
  none (between 1 and 8589934591, increasing...)
  [128373198878, 124, 23, 11, 6, 3, 5, 4]
  [123778473987, 124, 23, 11, 6, 3, 5, 4]
  [117578373378, 124, 23, 11, 6, 3, 5, 4]
  [113377378773, 124, 23, 11, 6, 3, 5, 4]
  [113373877778, 124, 23, 11, 6, 3, 5, 4]
  [113373378373, 124, 23, 11, 6, 3, 5, 4]
  [113373373378, 124, 23, 11, 6, 3, 5, 4]
  [113373373373, 124, 23, 11, 6, 3, 5, 4]

Searching for the smallest chain of length 9...
  none (between 1 and 137438953471, increasing...)
  none (between 1 and 2199023255551, increasing...)
  none (between 1 and 35184372088831, increasing...)
  none (between 1 and 562949953421311, increasing...)
  none (between 1 and 9007199254740991, increasing...)
  none (between 1 and 144115188075855871, increasing...)
  none (between 1 and 2305843009213693951, increasing...)
  none (between 1 and 36893488147419103231, increasing...)

Exception: Invalid string length

Stack trace:
Level 1 instruction: {"type":"not"}
Level 2 instruction: {"type":"greaterequal"}
Level 3 instruction: {"type":"call","name":"_anonymous1","width":1}
Level 4 instruction: {"type":"functionExpression","value":[8,"*_anonymous1"]}

real    7m5.415s
user    6m20.249s
sys     0m50.793s
```

If you have any questions, you can contact me on
[Twitter](https://twitter.com/cpatuzzo). Thanks.
