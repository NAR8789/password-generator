# password-generator

Rudimentary password generator, based on [this xkcd comic](https://xkcd.com/936/).

Word list is derived from the [Letterpress english word list](https://github.com/atebits/Words/blob/master/Words/en.txt), filtered down to only words between 3 and 7 characters.

## Usage

### Generate Password

```bash
cat word_list | ./generate.sh
```

### Update Word List

```bash
curl -s https://raw.githubusercontent.com/atebits/Words/master/Words/en.txt | ./trimwords.pl  > word_list 
```
