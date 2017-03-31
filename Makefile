DICTIONARY_SIZE ?= 8192
LENGTH          ?= 5

CACHE_DIR        = cache
EN_FULL          = ${CACHE_DIR}/en_full.txt
WORD_LIST        = word_list.txt
LONG_WORD_LIST   = long_word_list.txt

all: word_list password

password: ${LONG_WORD_LIST}
	@head -n ${DICTIONARY_SIZE} long_word_list.txt | ./generate.sh ${LENGTH}

long_password: ${LONG_WORD_LIST}
	@LENGTH=10 make -s password

flat_password: ${LONG_WORD_LIST}
	@echo $$(make -s password)

word_list: ${WORD_LIST}
${WORD_LIST}: ${LONG_WORD_LIST}
	head -n ${DICTIONARY_SIZE} ${LONG_WORD_LIST} > ${WORD_LIST}

# Some gotchas for the next time I edit this... character cleanup turns out to be tricky.
# - `tr` is not `utf-8` aware. `perl` is not by default `utf-8` aware, but has flags that enable it (`-C -Mutf8`). UTF-8
#   awareness is required for correct handling of greek inputs.
# - `iconv`'s `//TRANSLIT` behaves differently between linux and os x.
#   - OS X produces representations of stripped accent marks. Linux does not. (é => 'e vs é => e)
#   - Linux turns untransliterable characters (e.g. japanese, greek, cyrillic) into question marks '?', and these are not
#     dropped from output. (I have tried both `//IGNORE` and `-c`)
#   - This is why the `tr -dc '[:alpha:]\n'` pipe stpe lives on the same line--taken together, the output afterwards is
#     consistent between linux and os x. All the above nonesense goes away when we drop non-alphabetic characters.
# - Due to Makefile's continuation syntax (`\` only continues lines if it's the final character before the newline), I
#   can't find a way to comment on individual lines within the pipeline.
# 
# Given the amount of perl in here, it might be time to just turn this section into a perl script. My one worry would be
# finding an equivalent to `iconv`'s `ASCII//TRANSLIT` within perl's standard libraries.
${LONG_WORD_LIST}: ${EN_FULL}
	cat ${EN_FULL}                                                                \
	| perl -pe 's# \d+$$##'                                                       \
	| perl -C -Mutf8 -pe  'tr#οηυτνуα#onutvya#  # omicron to o, and other greeks' \
	| (iconv -f UTF-8 -t ASCII//TRANSLIT -c; true) | tr -dc '[:alpha:]\n'         \
	| sed '/^$$/d'                                                                \
	| perl -ne '$$H{$$_}++ or print'                                              \
	> ${LONG_WORD_LIST}

${EN_FULL}: ${CACHE_DIR}
	curl https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2016/en/en_full.txt > ${EN_FULL}

${CACHE_DIR}:
	mkdir -p ${CACHE_DIR}

clean:
	rm -rf ${CACHE_DIR} ${WORD_LIST} ${LONG_WORD_LIST}
