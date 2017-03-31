# password-generator

Yet another [xkcd-style password generator](https://xkcd.com/936/).

Word list is taken from [hermitdave/FrequencyWords](https://github.com/hermitdave/FrequencyWords/).

## Usage

Note: At the moment all sample commands below assume you are executing from the base directory of a clone of this repository.

### `generate.sh`

This is just a wrapper around `shuf`. Given input on stdin, it outputs 5 lines at random. Repeats are allowed.

```bash
$ cat word_list.txt | ./generate.sh
touch
farmers
costs
armies
caused
```

It optionally takes a count as an argument, to specify the number of lines to output

```bash
$ cat word_list.txt | ./generate.sh 10
execution
flour
extended
forbidden
foundation
muscles
benefits
cake
worst
fuel
```

`generate.sh` requires `shuf` or `gshuf` on your system.  On OS X, you can get `gshuf` as part of the `coreutils` package, through [Homebrew](https://brew.sh/).

```bash
brew install coreutils
```

### `make`

Alternately, I provide a set of convenience targets for `make`:
```bash
$ make password   # or just `make`. The default target invokes `password`.
pot
wax
steam
hurt
cape
```

```bash
$ make long_password
greece
mia
purchase
normal
interest
cab
rig
relationships
ross
corridor
```

```bash
$ make flat_password
injury aim assigned naive deserved
```

```bash
$ LENGTH=3 make password
flowing
magazine
grandson
```

The `Makefile` will also take a `DICTIONARY_SIZE` flag, to adjust the size of the word list it generates from. This defaults to 8192, which I've chosen because it seems a nice balance between memorability and password length. Being a power of 2, it also simplifies back of the envelope estimates of password entropy.

The `Makefile` also contains targets for rebuilding the word list.
```bash
$ make clean word_list
```
will wipe out the existing copy, and rebuild it from a fresh copy of the English word list in [hermitdave/FrequencyWords](https://github.com/hermitdave/FrequencyWords/).
