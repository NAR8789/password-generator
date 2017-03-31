CACHE_DIR=cache
EN_FULL=${CACHE_DIR}/en_full.txt
WORD_LIST=word_list.txt
LONG_WORD_LIST=long_word_list.txt
DICTIONARY_SIZE?=8192
LENGTH?=5

all: password

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
# - `iconv`'s `//TRANSLIT` behaves differently between linux and os x (é => e vs é => 'e)
# - `tr` is not `utf-8` aware. `perl` is not by default `utf-8` aware, but has flags that enable it.
${LONG_WORD_LIST}: ${EN_FULL}
	cat ${EN_FULL}                                                                \
	| perl -pe 's# \d+$$##'                                                       \
	| perl -C -Mutf8 -pe  'tr#οηυτνуα#onutvya#  # omicron to o, and other greeks' \
	| (iconv -f UTF-8 -t ASCII//TRANSLIT -c; true)                                \
	| tr -dc '[:alpha:]\n'                                                        \
	| sed '/^$$/d'                                                                \
	| perl -ne '$$H{$$_}++ or print'                                              \
	> ${LONG_WORD_LIST}

${EN_FULL}: ${CACHE_DIR}
	curl https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2016/en/en_full.txt > ${EN_FULL}

${CACHE_DIR}:
	mkdir -p ${CACHE_DIR}

clean:
	rm -rf ${CACHE_DIR} ${WORD_LIST} ${LONG_WORD_LIST}
