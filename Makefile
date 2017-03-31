CACHE_DIR=cache
EN_FULL=${CACHE_DIR}/en_full.txt
WORD_LIST=word_list.txt
DICTIONARY_SIZE?=8192
LENGTH?=5

all: password

password: ${WORD_LIST}
	@head -n ${DICTIONARY_SIZE} word_list.txt | ./generate.sh ${LENGTH}

long_password: ${WORD_LIST}
	@LENGTH=10 make password

flat_password: ${WORD_LIST}
	@echo $$(make password)

word_list: ${WORD_LIST}
${WORD_LIST}: ${EN_FULL}
	cat ${EN_FULL}                                                                \
	| perl -pe 's# [0-9]+$$##'                                                    \
	| perl -C -Mutf8 -pe  'tr#οηυτνуα#onutvya#  # omicron to o, and other greeks' \
	| (iconv -f UTF-8 -t ASCII//TRANSLIT -c; true)                                \
	| tr -dc '[:alpha:]\n'                                                        \
	| sed '/^$$/d'                                                                \
	| perl -ne '$$H{$$_}++ or print'                                              \
	> ${WORD_LIST}

${EN_FULL}: ${CACHE_DIR}
	curl https://raw.githubusercontent.com/hermitdave/FrequencyWords/master/content/2016/en/en_full.txt > ${EN_FULL}

${CACHE_DIR}:
	mkdir -p ${CACHE_DIR}

clean:
	rm -rf ${CACHE_DIR} ${WORD_LIST}
