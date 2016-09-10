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
