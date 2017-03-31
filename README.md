# password-generator

Yet another [xkcd-style password generator](https://xkcd.com/936/).

Word list is taken from [hermitdave/FrequencyWords](https://github.com/hermitdave/FrequencyWords/).

## Usage

### `generate.sh`

This is a glorified `shuf` wrapper--given input on stdin, it outputs 4 lines at random.

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

Alternately use the convenience targets in the `Makefile`:

```bash
$ make password
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
