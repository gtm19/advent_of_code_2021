# advent_of_code_2021
The home of my code written to tackle 2021's Advent of Code (https://adventofcode.com)

## Solutions

These are written in Ruby (2.7.4), and live in the [lib](/lib) directory.

## Setup (for tests)

Running tests requires `rspec`. If you are developing solutions in this repo, before running tests you would need to run (in the terminal):

```sh
bundle install
```

## Initialising a new task

You can create the basic template files for a given task by running (for example):

```sh
rake 'init[dec_01]'
```

This will create (and initialise with some boilerplate code) the following files:

* `lib/dec_01.rb`
* `spec/dec_01_spec.rb` (for tests)
* `inputs/test/test_dec_01.txt` (for test data)
* `inputs/dec_01.txt` (for challenge input)

Then you just have to copy the inputs from the challenge into the `inputs/` files.

Running `rake` immediately afterwards should result in 2 failures.

## `rake`

You can run tests by simply running `rake` at the terminal, or you can run the code to produce the solutions by running (for example):

```sh
rake dec_01
```

If you want to do this for your own input data, replace the relevant files in the [inputs](/inputs) directory first.
