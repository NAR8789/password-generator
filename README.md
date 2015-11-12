# password-generator

Rudimentary password generator, based on [this xkcd comic](https://xkcd.com/936/).

Word list is derived from the [Letterpress english word list](https://github.com/atebits/Words/blob/master/Words/en.txt), filtered down to only words between 3 and 7 characters.

### `generate.sh`

Glorified `shuf` wrapper--given input on stdin, outputs 4 lines at random.

```bash
$ cat word_list | ./generate.sh
egma
chaplet
thatch
goobies
```

Optionally takes a count as an argument, to specify the number of lines to output

```bash
$ cat word_list | ./generate.sh 8
inherit
slokens
schemes
muses
liars
praam
pippier
nerals
```

### `update_word_list.sh`

One-liner for updating the word list.
