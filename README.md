# password-generator

Rudimentary password generator, based on [this xkcd comic](https://xkcd.com/936/).

Word list is derived from the [Letterpress english word list](https://github.com/atebits/Words/blob/master/Words/en.txt), filtered down to only words between 3 and 7 characters.

### `generate.sh`

Glorified `shuf` wrapper--given input on stdin, outputs 4 lines at random.

```bash
$ cat word_list | ./generate.sh
4 egma
7 chaplet
6 thatch
7 goobies
```

Optionally takes a count as an argument, to specify the number of lines to output

```bash
$ cat word_list | ./generate.sh 8
7 inherit
7 slokens
7 schemes
5 muses
5 liars
5 praam
7 pippier
```

### `trimwords.pl`

For preparing the word list. Takes a newline-separated word list, prepends character counts, and filters to only words between 3 and 7 characters long.

```bash
$ curl -s https://raw.githubusercontent.com/atebits/Words/master/Words/en.txt | ./trimwords.pl > word_list 
```
